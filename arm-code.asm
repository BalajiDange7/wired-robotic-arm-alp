//#include<16f917.h>
//#include<16f690.h>
//#include<18f4520.h>
#include<18f4431.h>
#DEVICE ADC=10

#fuses INTRC_IO,PROTECT,BROWNOUT,NOMCLR,NOCPD,NOWDT,NOPUT,FCMEN


void main(void)
{

//  int8 ucVar = 0;
    

    SETUP_ADC(ADC_OFF);                           //Disable ADC IP
    SETUP_ADC_PORTS(NO_ANALOGS);                 //Disable Analog IP
//  SETUP_COMPARATOR(NC_NC_NC_NC);
    SETUP_CCP1(CCP_OFF);
    

    
    SET_TRIS_A(0x00);//0000 0000
    SET_TRIS_B(0x00);//0000 0000
    SET_TRIS_C(0x8F);//1000 1111
    SET_TRIS_D(0x83);//1000 0011
    SET_TRIS_E(0x00);//0000 0000

    
    SET_TRIS_A(0x00);//0000 0000
    SET_TRIS_B(0x00);//0000 0000
    SET_TRIS_C(0xF1);//1111 0001
    SET_TRIS_D(0x0F);//0000 1111
    SET_TRIS_E(0x00);//0000 0000

//   
    adfm=true;


//  SET_UP_ADC_PORTS(sAN2|sAN4|sAN7);//sAN0|sAN1);|sAN9|sAN10|sAN11|sAN12|sAN13);sAN0);
    
    setup_power_pwm_pins(PWM_COMPLEMENTARY,PWM_COMPLEMENTARY,PWM_COMPLEMENTARY,PWM_COMPLEMENTARY);
    

//  setup_power_pwm_pins(PWM_ODD_ON,PWM_ODD_ON,PWM_ODD_ON,PWM_ODD_ON);
    
    setup_power_pwm(PWM_CLOCK_DIV_64 | PWM_FREE_RUN | PWM_DEAD_CLOCK_DIV_4,1,10000,2300,0,1,0);
    
    SETUP_TIMER_1(T1_INTERNAL|T1_DIV_BY_8);        //Enables Timer1
    SET_TIMER1(40536);                             //Timer of 200ms(64286); 10ms


//  enable_interrupts(INT_RDA);
    ENABLE_INTERRUPTS(INT_TIMER1);


//  setup_wdt(WDT_2304MS);
//  RLY_OFF;
//  RLY_OFF_T;
    
    
    ENABLE_INTERRUPTS(GLOBAL);

    set_power_pwm0_duty(800);
    delay_ms(350);

    set_power_pwm2_duty(800);
    delay_ms(350);

    set_power_pwm4_duty(800);
    delay_ms(350);

    set_power_pwm6_duty(800);
    delay_ms(350);
 
 
//  RLY_OFF;
    delay_ms(10);

    
//  write_eeprom(MLOC_WRNG_ATMP_CNT,ucWrngAtmpCNT);
//  ucPaswd_3_Indx = read_EEPROM(MLOC_PSWD_3_INDX);
//  delay_ms(350);
//  BUZZ_ON;
//  delay_ms(350);
    BUZZ_OFF;
    BUZZ_OFF;
    BUZZ_OFF;
    
    
    while(1)
    {

        delay_us(10);
        if((INPUT(Elbo_L) == 0) && (deg_elbow < 1020))
        {
            deg_elbow++;
            set_power_pwm0_duty(deg_elbow);
            delay_ms(20);
        }
        else if((INPUT(Elbo_R) == 0) && (deg_elbow > 480))
        {
            deg_elbow--;
            set_power_pwm0_duty(deg_elbow);
            delay_ms(20);
        }
		
		
        //--------------BASE--------------------------------------------
     
        
		if(INPUT(Base_L) == 0)
        {
            reverse();
            delay_ms(100);
        }
        if(INPUT(Base_R) == 0)
        {
            forward();
            //reverse();
            delay_ms(100);
        }
		
		
        //--------------WRIST---------------------------------------------
        
		
		if((INPUT(Wrist_L) == 0) && (deg_wrist < 1020))
        {
            deg_wrist++;
            set_power_pwm2_duty(deg_wrist);
            delay_ms(20;)
        }
        else if((INPUT(Wrist_R) == 0) && (deg_wrist > 480))
        {
            deg_wrist--;
            set_power_pwm2_duty(deg_wrist);
            delay_ms(20);
        }
		
		
        //---------------ROATATING GRIPPER-----------------------------------
        
		
		if((INPUT(R_gripper_L) == 0) && (deg_r_grip < 1020))
        {
            deg_r_grip++;
            set_power_pwm4_duty(deg_r_grip);
            delay_ms(20);
        }
        else if((INPUT(R_gripper_R) == 0) && (deg_r_grip > 480))
        {
            deg_r_grip--;
            set_power_pwm4_duty(deg_r_grip);
            delay_ms(20);
        }
		
		
        //---------------------Gripper------------------------------------------
        
		
		if((INPUT(Gripper_L) == 0) && (deg_grip < 1020))
        {
            deg_geip++;
            set_power_pwm6_duty(deg_grip);
            delay_ms(20);
        }
        else if((INPUT(Gripper_R) == 0) && (deg_grip > 480))
        {
            deg_grip--;
            set_power_pwm6_duty(deg_grip);
            delay_ms(20);
        }
    }
