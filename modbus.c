#include<stdio.h>
#include<string.h>
#include <stdint.h>
#include <stdlib.h>

const uint8_t device_id = 0x01;
const uint8_t holding_register = 0x03;
const uint8_t coil_register = 0x01;
const uint16_t starting_address = 0x0000;
const uint16_t last_address = 0xFFF9;
const uint16_t starting_quantity = 0x0000;
const uint16_t last_quantity = 0x07D0; 

//checking for whether the device is called or not
uint8_t mb_req_pdu_server(uint8_t crc_ok, uint8_t device_called){
    if(crc_ok== UINT8_C(5) && device_called==UINT8_C(5)){
        return UINT8_C(5);
    }
    else{
        return UINT8_C(0);
    }
}

uint8_t read_from_memory(){
    const uint8_t a = 1;
    if(a==1){
        return UINT8_C(5);
    }
    else{
        return UINT8_C(0);
    }
}

uint8_t check_is_readable(){
    if(read_from_memory()==UINT8_C(5)){
        return UINT8_C(5);
    }
    else{
        return UINT8_C(0x04);
    }
}

//checking for a valid functional code
uint8_t check_valid_function_code(uint8_t code){
    if(code==holding_register || code==coil_register){
        return UINT8_C(5);
    }
    else{
        return UINT8_C(0x01);
    }
}
//check valid quantity
uint8_t check_valid_quantity(uint16_t quantity){
    if(starting_quantity<=quantity && last_quantity>=quantity){
        return UINT8_C(5);
    }
    else{
        return UINT8_C(0x03);
    }
}

uint8_t check_address(uint32_t address){
    if(address>=starting_address && address<=last_address){
        return UINT8_C(5);
    }
    else{
        return UINT8_C(0);
    }
}



uint8_t check_valid_address_and_quantity(uint16_t address, uint16_t quantity){
    uint16_t new_address = address + quantity;
    //printf(" %8X \n", new_address);
    if(check_address(address)==UINT8_C(5) && check_address(new_address)==UINT8_C(5)){
        return UINT8_C(5);
    }
    else{
        return UINT8_C(0x02);
    }
}

// uint8_t check_valid_start_address_and_quantity(uint16_t start_address, uint16_t quantity){
    
// }


//CRC comparing
uint8_t CRC_Check(unsigned int cal_crc, unsigned int trans_crc){
    if(cal_crc==trans_crc){
        return UINT8_C(5);
    }
    else{
        return UINT8_C(0);
    }
}

//address checking
uint8_t address_id_check(uint8_t id){
    if(id==device_id){
        return UINT8_C(5);
    }
    else{
        return UINT8_C(0);
    }
}

// crc calculation 
unsigned int CRC16_2(unsigned char *buf, int len)
{  
  unsigned int crc = 0xFFFF;
  for (int pos = 0; pos < len; pos++)
  {
  crc ^= (unsigned int)buf[pos];    // XOR byte into least sig. byte of crc

  for (int i = 8; i != 0; i--) {    // Loop over each bit
    if ((crc & 0x0001) != 0) {      // If the LSB is set
      crc >>= 1;                    // Shift right and XOR 0xA001
      crc ^= 0xA001;
    }
    else                            // Else LSB is not set
      crc >>= 1;                    // Just shift right
    }
  }

  return crc;
}

unsigned char* error_generate(uint8_t function_code, uint8_t exception_code){
    unsigned char* error=malloc(2);
    uint8_t error_code = 0x80+function_code;
    error[0]= error_code;
    error[1] = exception_code;
    return error;
}



unsigned char* check_function(unsigned char data[6], unsigned int streamed_crc){
    unsigned int crc_calulated = CRC16_2(data, 6);
    //printf(" %4x", crc_calulated);
    uint8_t crc_ok = CRC_Check(crc_calulated, streamed_crc);
    //printf(" %u", crc_ok);
    uint8_t called_device_id = data[0];
    uint8_t called_device_ok= address_id_check(called_device_id);
    //printf(" %u ", called_device_ok);
    uint8_t server_ok = mb_req_pdu_server(crc_ok, called_device_ok);
    //printf(" %u ", server_ok);
    uint8_t fun_code = data[1];
    //printf(" %8X ", fun_code);
    // uint8_t start_address_h = data[2];
    // uint8_t start_address_l = data[3];
    // uint8_t quantity_address_h = data[4];
    // uint8_t quantity_address_l = data[5];
    uint16_t start_address = ((uint16_t)data[2] << 8) | (uint16_t) data[3];
    //printf("%4X", start_address );
    uint16_t quantity = ((uint16_t)data[4] << 8) | (uint16_t) data[5];
    
    //quantity = 0x07A0;
    //start_address = 0xF82A;
    //printf("%4X", quantity );
    if(server_ok==UINT8_C(5)){
        uint8_t fun_code_ok = check_valid_function_code(data[1]);
        if(fun_code_ok==UINT8_C(5)){
            uint8_t quantity_check =check_valid_quantity(quantity);
            if(quantity_check==UINT8_C(5)){
                uint8_t check_add_quant = check_valid_address_and_quantity(start_address, quantity);
                if(check_add_quant==UINT8_C(5)){
                    uint8_t check_readable = check_is_readable();
                    if(check_readable==UINT8_C(5)){
                        printf("Ok!\n");
                        unsigned char *err = malloc(2);
                        return err;
                    }
                    else{
                        unsigned char *err = malloc(2);
                        err =  error_generate(fun_code, check_readable);
                        return err;
                    }
                }
                else{
                    unsigned char *err = malloc(2);
                    err =  error_generate(fun_code, check_add_quant);
                    return err;
                }
            }
            else{
                unsigned char *err = malloc(2);
                err =  error_generate(fun_code, quantity_check);
                return err;
            }
        }
        else{
            unsigned char *err = malloc(2);
            err =  error_generate(fun_code, fun_code_ok);
            return err;
        }
    }
    else{
        unsigned char *err = malloc(2);
        err[0] = 't';
        return err;
    }


}


int main(){

    //01 03 00 01 00 0A 94 0D
//01 01 00 01 00 05 AD C9
//01 01 00 1B 00 19 8D C7
    unsigned char p[6]={0x01, 0x01, 0X00, 0X01, 0x00, 0x05};
    unsigned int crc = 0xC9AD;
    // uint8_t start_address_h = p[2];
    // uint8_t start_address_l = p[3];
    // uint8_t quantity_address_h = p[4];
    // uint8_t quantity_address_l = p[5];
    // uint16_t crc = 0x0D94;
    // uint16_t start_address = ((uint16_t)start_address_h << 8) | (uint16_t) start_address_l;
    // uint16_t quantity = ((uint16_t)quantity_address_h << 8) | (uint16_t) quantity_address_l;
    
    // uint16_t new_add = start_address+quantity;
    // printf("%8X", new_add);
    // uint8_t valid= check_valid_address_and_quantity(start_address, quantity);
    // printf("%8X", valid);
    unsigned char* result = check_function(p, crc);
    for(int i=0; i<2;i++){
        printf("%x", result[i]);
        printf(" ,");
    }
    
}

//01 03 00 01 00 0A 94 0D
//01 01 00 01 00 05 AD C9
//01 01 00 1B 00 19 8D C7