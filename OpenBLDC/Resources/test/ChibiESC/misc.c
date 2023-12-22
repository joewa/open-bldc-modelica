/*
 * misc.c
 *
 *  Created on: 26.08.2016
 *      Author: joerg
 */

#include "misc.h"

inline float minus(float a, float b){
	if(ABS(a - b) < M_PI){
		return(a - b);
	}
	else if(a > b){
		return(a - b - 2.0 * M_PI);
	}
	else{
		return(a - b + 2.0 * M_PI);
	}
}
//TODO: blocks hal with large numbers
inline float mod(float a){
	while(a < -M_PI){
		a += 2.0 * M_PI;
	}
	while(a > M_PI){
		a -= 2.0 * M_PI;
	}
	return(a);
}
