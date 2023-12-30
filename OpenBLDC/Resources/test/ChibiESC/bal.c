/*
 * This file is part of the stmbl project.
 *
 * Copyright (C) 2013-2015 Rene Hopf <renehopf@mac.com>
 * Copyright (C) 2013-2015 Nico Stute <crinq@crinq.de>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <string.h>
#include <math.h>
#include "bal.h"

hal_struct_t bal;

char* itoa(int i){
  bal.tmp[0] = (i % 10) + '0';
  bal.tmp[1] = '\0';
  return(bal.tmp);
}

void hal_init(){
  bal.comp_type_count = 0;
  for(int i = 0; i < MAX_COMP_TYPES; i++){
    bal.comp_types_counter[i] = 0;
  }
  bal.hal_pin_count = 0;
  bal.comp_count = 0;

  bal.nrt_init_func_count = 0;
  bal.rt_func_count = 0;
  bal.nrt_func_count = 0;
  bal.frt_func_count = 0;

  bal.link_errors = 0;
  bal.pin_errors = 0;
  bal.set_errors = 0;
  bal.get_errors = 0;
  bal.comp_errors = 0;

  bal.rt_state = RT_STOP;
  bal.frt_state = FRT_STOP;
  bal.hal_state = HAL_OK;
  bal.active_rt_func = -1;
  bal.active_frt_func = -1;
  bal.active_nrt_func = -1;
  strcpy(bal.error_name,"no error");
}

void hal_comp_init(){
   for(int i = 0; i < bal.nrt_init_func_count; i++){ // run nrt init
      bal.nrt_init[i]();
   }
}

void hal_run_nrt(float period){
   //run all non realtime hal functions
   for(bal.active_nrt_func = 0; bal.active_nrt_func < bal.nrt_func_count; bal.active_nrt_func++){
      bal.nrt[bal.active_nrt_func](period);
   }
   bal.active_nrt_func = -1;
}

void hal_run_rt(float period){
   //run all realtime hal functions
   for(bal.active_rt_func = 0; bal.active_rt_func < bal.rt_func_count; bal.active_rt_func++){
      bal.rt[bal.active_rt_func](period);
   }
   bal.active_rt_func = -1;
}

void hal_run_frt(float period){
   //run all fast realtime hal functions
   for(bal.active_frt_func = 0; bal.active_frt_func < bal.frt_func_count; bal.active_frt_func++){
      bal.frt[bal.active_frt_func](period);
   }
   bal.active_frt_func = -1;
}

int hal_start_rt(){
   if(bal.rt_state == RT_STOP && bal.hal_state == HAL_OK){
      bal.active_rt_func = -1;
      bal.rt_state = RT_SLEEP;
      return(1);
   }
   return(0);
}

void hal_start(){
   float min = INFINITY;
   int min_index = -1;
   float rt_prio = 0.0;
   float frt_prio = 0.0;

   char added[MAX_COMPS];

   for(int i = 0; i < MAX_COMPS; i++){
      added[i] = 0;
   }
   // add rt func
   bal.rt_func_count = 0;
   for(int i = 0; i < bal.comp_count; i++){
      min = INFINITY;
      min_index = -1;
      for(int j = bal.comp_count - 1; j >= 0; j--){
         rt_prio = bal.hal_pins[bal.hal_comps[j]->hal_pin_start_index + 2]->source->source->value;
         if(rt_prio <= min && added[j] == 0 && rt_prio >= 0.0 && bal.hal_comps[j]->rt != 0){
            min = rt_prio;
            min_index = j;
         }
      }
      if(min_index >= 0){
         added[min_index] = 1;
         bal.rt[bal.rt_func_count++] = bal.hal_comps[min_index]->rt;
      }
   }

   for(int i = 0; i < bal.comp_count; i++){
      added[i] = 0;
   }
   // add frt func
   bal.frt_func_count = 0;
   for(int i = 0; i < bal.comp_count; i++){
      min = INFINITY;
      min_index = -1;
      for(int j = bal.comp_count - 1; j >= 0; j--){
         frt_prio = bal.hal_pins[bal.hal_comps[j]->hal_pin_start_index + 3]->source->source->value;
         if(frt_prio <= min && added[j] == 0 && frt_prio >= 0.0 && bal.hal_comps[j]->frt != 0){
            min = frt_prio;
            min_index = j;
         }
      }
      if(min_index >= 0){
         added[min_index] = 1;
         bal.frt[bal.frt_func_count++] = bal.hal_comps[min_index]->frt;
      }
   }
   // add (de)init func
   bal.rt_init_func_count = 0;
   bal.rt_deinit_func_count = 0;
   for(int i = 0; i < bal.comp_count; i++){
      rt_prio = bal.hal_pins[bal.hal_comps[i]->hal_pin_start_index + 2]->source->source->value;
      frt_prio = bal.hal_pins[bal.hal_comps[i]->hal_pin_start_index + 3]->source->source->value;

      if(rt_prio >= 0.0 || frt_prio >= 0.0){
         if(bal.hal_comps[i]->rt_init != 0){
            bal.rt_init[bal.rt_init_func_count++] = bal.hal_comps[i]->rt_init;
         }
         if(bal.hal_comps[i]->rt_deinit != 0){
            bal.rt_deinit[bal.rt_deinit_func_count++] = bal.hal_comps[i]->rt_deinit;
         }
      }
   }
   for(int i = 0; i < bal.rt_init_func_count; i++){
      bal.rt_init[i]();
   }

   hal_start_rt();

   if(bal.frt_func_count > 0){
      hal_start_frt();
      hal_enable_frt();
   }
   hal_enable_rt();
}

void hal_stop(){
   hal_stop_frt();
   hal_stop_rt();
   hal_disable_frt();
   hal_disable_rt();
   for(; bal.rt_deinit_func_count > 0; bal.rt_deinit_func_count--){
      bal.rt_deinit[bal.rt_deinit_func_count - 1]();
   }
}

int hal_start_frt(){
   if(bal.frt_state == FRT_STOP && bal.hal_state == HAL_OK){
      bal.active_frt_func = -1;
      bal.frt_state = FRT_SLEEP;
      return(1);
   }
   return(0);
}

void hal_stop_rt(){
   bal.active_rt_func = -1;
   bal.rt_state = RT_STOP;
   bal.active_rt_func = -1;
   bal.rt_state = RT_STOP;
}

void hal_stop_frt(){
   bal.active_frt_func = -1;
   bal.frt_state = FRT_STOP;
   bal.active_frt_func = -1;
   bal.frt_state = FRT_STOP;
}

void hal_init_pin(hal_name_t name, hal_pin_t* pin, float value){
  strncpy(pin->name, bal.comp_types[bal.comp_type], HAL_NAME_LENGTH);
  strncat(pin->name, itoa(bal.comp_types_counter[bal.comp_type]), HAL_NAME_LENGTH);
  strncat(pin->name, ".", HAL_NAME_LENGTH);
  strncat(pin->name, name, HAL_NAME_LENGTH);
  pin->value = value;
  pin->source = pin;
  hal_register_pin(pin);
}

int hal_register_pin(hal_pin_t* pin){
  if(bal.hal_pin_count >= MAX_HAL_PINS){
    bal.pin_errors++;
    return(0);
  }

  for(int i = 0; i < bal.hal_pin_count; i++){
    if(!strcmp(bal.hal_pins[i]->name, pin->name)){
      bal.pin_errors++;
      return(0);
    }
  }

  bal.hal_pins[bal.hal_pin_count] = pin;
  bal.hal_pin_count++;

  return(1);
}

int hal_set_pin(hal_name_t name, float value){
  for(int i = 0; i < bal.hal_pin_count; i++){
    if(!strcmp(bal.hal_pins[i]->name, name)){
      bal.hal_pins[i]->value = value;
      bal.hal_pins[i]->source = bal.hal_pins[i];
      return(1);
    }
  }
  strcpy(bal.error_name,name);
  bal.set_errors++;
  return(0);
}

int hal_is_pin(hal_name_t name){
  for(int i = 0; i < bal.hal_pin_count; i++){
    if(!strcmp(bal.hal_pins[i]->name, name)){
      return(1);
    }
  }
  return(0);
}

int hal_is_compname(hal_name_t name){
  for(int i = 0; i < bal.hal_pin_count; i++){
    if(!strncmp(bal.hal_pins[i]->name, name, strlen(name))){
      return(1);
    }
  }
  return(0);
}

float hal_get_pin(hal_name_t name){
  for(int i = 0; i < bal.hal_pin_count; i++){
    if(!strcmp(bal.hal_pins[i]->name, name)){
      return(bal.hal_pins[i]->source->source->value);
    }
  }
  bal.get_errors++;
  return(0.0);
}

hal_pin_t hal_map_pin(hal_name_t name){
    for(int i = 0; i < bal.hal_pin_count; i++){
      if(!strcmp(bal.hal_pins[i]->name, name)){
		  return(*bal.hal_pins[i]);
      }
    }
    return(*bal.hal_pins[0]);
}

void hal_write_pin(hal_pin_t* pin, float value){
  pin->value = value;
  pin->source = pin;
}

float hal_read_pin(hal_pin_t* pin){
  return(pin->source->source->value);
}

hal_pin_t* hal_find_pin(hal_name_t name){
  for(int i = 0; i < bal.hal_pin_count; i++){
    if(!strcmp(bal.hal_pins[i]->name, name)){
      return(bal.hal_pins[i]);
    }
  }
  return(0);
}

int hal_link_pins(hal_name_t source, hal_name_t sink){
  hal_pin_t* d;
  hal_pin_t* s;
  d = hal_find_pin(source);
  s = hal_find_pin(sink);

  if(d != 0 && s != 0){
    s->value = s->source->source->value;
    s->source = d;
	return(1);
  }
  strcpy(bal.error_name,source);
  bal.link_errors++;
  return(0);
}

int hal_set_comp_type(hal_name_t name){
  for(int i = 0; i < bal.comp_type_count; i++){
    if(!strcmp(bal.comp_types[i], name)){
      bal.comp_type = i;
      return(bal.comp_types_counter[bal.comp_type]++);
    }
  }

  if(bal.comp_type_count < MAX_COMP_TYPES){
    strncpy(bal.comp_types[bal.comp_type_count], name, HAL_NAME_LENGTH);
    bal.comp_type = bal.comp_type_count++;
    return(0);
  }
  bal.comp_errors++;
  return(-1);
}

void hal_add_comp(hal_comp_t* comp){
   if(comp != 0 && bal.comp_count < MAX_COMPS){
      bal.hal_comps[bal.comp_count++] = comp;
      comp->instance = bal.comp_types_counter[bal.comp_type];
      if(comp->nrt_init != 0){
         bal.nrt_init[bal.nrt_init_func_count++] = comp->nrt_init;
      }
      if(comp->nrt != 0 && bal.nrt_func_count < MAX_COMPS){
         bal.nrt[bal.nrt_func_count++] = comp->nrt;
      }
   }
   else{
      bal.comp_errors++;
   }
}
