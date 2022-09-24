/** TCP/IP client as closed loop position controller for testing the MDDTCPIPServer (Modelica) code.
 *
 * @file
 * @author      joewa
 * @since       2022-09-24
 * 
 * Based on test_MDDTCPIPSocketClient.c
*/

#define WINVER 0x0501

#include <stdio.h>
#include "../../Include/MDDTCPIPSocket.h"
#include "../../src/include/util.h" /* MDD_msleep(..) */


float clamp( float value, float min, float max ) {
    return (value < min) ? min : (value > max) ? max : value;
}


int main(void) {
    void * client;
    float arr_out[1];  // must be 32-bit float
    float arr_in[2];
    char sendMessage[16];
    const char *recMessage;
    int i;
    float r, y, u;

    client = MDD_TCPIPClient_Constructor();
    if (client == 0) {
        perror("client == NULL\n");
        exit(EXIT_FAILURE);
    }

    if (MDD_TCPIPClient_Connect(client, "localhost", 10002)) {
        //for (int i = 0; i < 20; i=i+1) {
        while(1) {
            // Read
            recMessage = MDD_TCPIPClient_Read(client, sizeof(arr_in));
            memcpy(arr_in, recMessage, sizeof(arr_in));
            r = arr_in[0];
            y = arr_in[1];
            printf("r: %f, y: %f\n", r, y);
            u = clamp(25.0 * (r - y), -10, 10);
            // Write
            arr_out[0] = u;
            memcpy(sendMessage, arr_out, sizeof(arr_out));
            MDD_TCPIPClient_Send(client, sendMessage, sizeof(arr_out));
            //MDD_msleep(125);
        }
    }

    MDD_TCPIPClient_Destructor(client);
    return EXIT_SUCCESS;
}
