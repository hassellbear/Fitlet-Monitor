#!/usr/bin/perl -w
#
#FitMon.pl

# Darryl Hassell 6/3/2014

use Tk;


# Define & Initialize Variables

# System Uptime
$_ = '--' for my ($Uptime_String, $Uptime, $Uptime_Label, $Uptime_Hours, $Uptime_Minutes, $Uptime_Seconds);

# Governors
$_ = '--' for my ($Avail_Gov, $Avail_Gov_Label, $CPU0_Gov, $CPU0_Gov_Label, $CPU1_Gov, $CPU1_Gov_Label, $CPU2_Gov, $CPU2_Gov_Label, $CPU3_Gov, $CPU3_Gov_Label);

# CPU Temperature
$_ = '--' for my ($CPU_Temp_Unfiltered1, $CPU_Temp_Array1,$CPU_Temp_Unfiltered2, $CPU_Temp_Array2, $CPU_Temp, $CPU_Temp_Label);

# SSD Temperature
$_ = '--' for my ($SSD_Temp_Unfiltered1, $SSD_Temp_Array1,$SSD_Temp_Unfiltered2, $SSD_Temp_Array2, $SSD_Temp, $SSD_Temp_Label);

# CPU0 Frequencies
$_ = '--' for my ($CPU0_Min_Freq, $CPU0_Min_Label, $CPU0_Max_Freq, $CPU0_Max_Label, $CPU0_Oper_Freq, $CPU0_Oper_Label, $CPU0_Time_In_State, $CPU0_Freq1, $CPU0_Ticks1, $CPU0_Freq2, $CPU0_Ticks2, $CPU0_Avg_Freq, $CPU0_Avg_Label);

# CPU1 Frequencies
$_ = '--' for my ($CPU1_Min_Freq, $CPU1_Min_Label, $CPU1_Max_Freq, $CPU1_Max_Label, $CPU1_Oper_Freq, $CPU1_Oper_Label, $CPU1_Time_In_State, $CPU1_Freq1, $CPU1_Ticks1, $CPU1_Freq2, $CPU1_Ticks2, $CPU1_Avg_Freq, $CPU1_Avg_Label);

# CPU2 Frequencies
$_ = '--' for my ($CPU2_Min_Freq, $CPU2_Min_Label, $CPU2_Max_Freq, $CPU2_Max_Label, $CPU2_Oper_Freq, $CPU2_Oper_Label, $CPU2_Time_In_State, $CPU2_Freq1, $CPU2_Ticks1, $CPU2_Freq2, $CPU2_Ticks2, $CPU2_Avg_Freq, $CPU2_Avg_Label);

# CPU3 Frequencies
$_ = '--' for my ($CPU3_Min_Freq, $CPU3_Min_Label, $CPU3_Max_Freq, $CPU3_Max_Label, $CPU3_Oper_Freq, $CPU3_Oper_Label, $CPU3_Time_In_State, $CPU3_Freq1, $CPU3_Ticks1, $CPU3_Freq2, $CPU3_Ticks2, $CPU3_Avg_Freq, $CPU3_Avg_Label);

# Create Main Window
$WinMain = MainWindow->new;
$WinMain -> resizable (0,0);

# Label Main Window
$myframe = $WinMain -> Frame ();
$myframe -> Label(-text => 'Fitlet Temperature and CPU Performance Data', -font => "helvetica 13 bold") -> pack ();
$myframe -> pack ();

# Create Miscellaneous Window
$myframeMisc = $WinMain -> Frame ();
$myframeMisc -> pack (-side => 'top');
$myframeMisc -> pack (-padx => 10, -pady => 10);

# Create UpTime Window
$myframeUptime = $myframeMisc -> Frame (-relief => 'groove', -bd => 5);
$myframeUptime -> Label(-text => 'System Up Time', -font => "helvetica 12 bold") -> pack ();
$Uptime_Label = $myframeUptime -> Label (-text => "$Uptime_Hours".':'."$Uptime_Minutes".':'."$Uptime_Seconds".'(hr:min:sec)', -foreground => "red", -font => "helvetica 11 bold") -> pack (-pady => 29);
$myframeUptime -> pack (-side => 'left');
$myframeUptime -> pack (-padx => 10, -pady => 10);

# Create Temperature Window
$myframeTemp = $myframeMisc -> Frame (-relief => 'groove', -bd => 5);
$myframeTemp -> Label(-text => 'System Temperatures', -font => "helvetica 12 bold") -> pack ();
$myframeTemp -> pack (-side => 'right');
$myframeTemp -> pack (-padx => 10, -pady => 10);

# CPU Temperature
$myframeCPUTemp = $myframeTemp -> Frame (-relief => 'groove', -bd => 5);
$myframeCPUTemp -> Label (-text => 'CPU', -font => "helvetica 12 bold") -> pack ();
$CPU_Temp_Label = $myframeCPUTemp -> Label (-text => "$SSD_Temp".'Deg. C.', -foreground => 'red', -font => "helvetica 11 bold")->pack();
$myframeCPUTemp -> pack (-side => 'left');
$myframeCPUTemp -> pack (-padx => 10, -pady => 10);

# SSD Temperature
$myframeSSDTemp = $myframeTemp -> Frame (-relief => 'groove', -bd => 5);
$myframeSSDTemp -> Label (-text => 'SSD', -font => "helvetica 12 bold") -> pack ();
$SSD_Temp_Label = $myframeSSDTemp -> Label (-text => "$SSD_Temp".'Deg. C.', -foreground => 'red', -font => "helvetica 11 bold")->pack();
$myframeSSDTemp -> pack (-side => 'left');
$myframeSSDTemp -> pack (-padx => 10, -pady => 10);

# Create CPU Frequency Governor Window
$myframeGovernor = $WinMain -> Frame (-relief => 'groove', -bd => 5);
$myframeGovernor -> Label(-text => 'CPU Frequency Governors', -font => "helvetica 12 bold") -> pack ();
$myframeGovernor -> pack (-side => 'top');
$myframeGovernor -> pack (-padx => 10, -pady => 10);

# Available Governors
$myframeAvailGov = $myframeGovernor -> Frame (-relief => 'groove', -bd => 5);
$myframeAvailGov -> Label (-text => 'Available', -font => "helvetica 12 bold") -> pack (-pady => 1);
$Avail_Gov = `sudo cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors`;
$Avail_Gov_Label = $myframeAvailGov -> Label(-text => "$Avail_Gov", -foreground => 'darkblue', -font => "helvetica 11 bold") -> pack (-pady => 28);
$myframeAvailGov -> pack (-side => 'left');
$myframeAvailGov -> pack (-padx => 10, -pady => 10);

# Active Governors
$myframeActiveGov = $myframeGovernor -> Frame (-relief => 'groove', -bd => 5);
$myframeActiveGov -> Label (-text => 'Active', -font => "helvetica 12 bold") -> pack ();
$myframeActiveGov -> pack (-side => 'left');
$myframeActiveGov -> pack (-padx => 10, -pady => 10);

# CPU0 Governor
$myframeCPU0Gov = $myframeActiveGov -> Frame (-relief => 'groove', -bd => 5);
$myframeCPU0Gov -> Label (-text => 'CPU0', -font => "helvetica 12 bold") -> pack ();
$CPU0_Gov = `sudo cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor`;
$CPU0_Gov_Label = $myframeCPU0Gov -> Label(-text => "$CPU0_Gov", -foreground => 'darkblue', -font => "helvetica 11 bold") -> pack ();
$myframeCPU0Gov -> pack (-side => 'left');
$myframeCPU0Gov -> pack (-padx => 10, -pady => 10);

# CPU1 Governor
$myframeCPU1Gov = $myframeActiveGov -> Frame (-relief => 'groove', -bd => 5);
$myframeCPU1Gov -> Label (-text => 'CPU1', -font => "helvetica 12 bold") -> pack ();
$CPU1_Gov = `sudo cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor`;
$CPU1_Gov_Label = $myframeCPU1Gov -> Label(-text => "$CPU1_Gov", -foreground => 'darkblue', -font => "helvetica 11 bold") -> pack ();
$myframeCPU1Gov -> pack (-side => 'left');
$myframeCPU1Gov -> pack (-padx => 10, -pady => 10);

# CPU2 Governor
$myframeCPU2Gov = $myframeActiveGov -> Frame (-relief => 'groove', -bd => 5);
$myframeCPU2Gov -> Label (-text => 'CPU2', -font => "helvetica 12 bold") -> pack ();
$CPU2_Gov = `sudo cat /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor`;
$CPU2_Gov_Label = $myframeCPU2Gov -> Label(-text => "$CPU2_Gov", -foreground => 'darkblue', -font => "helvetica 11 bold") -> pack ();
$myframeCPU2Gov -> pack (-side => 'left');
$myframeCPU2Gov -> pack (-padx => 10, -pady => 10);

# CPU3 Governor
$myframeCPU3Gov = $myframeActiveGov -> Frame (-relief => 'groove', -bd => 5);
$myframeCPU3Gov -> Label (-text => 'CPU3', -font => "helvetica 12 bold") -> pack ();
$CPU3_Gov = `sudo cat /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor`;
$CPU3_Gov_Label = $myframeCPU3Gov -> Label(-text => "$CPU3_Gov", -foreground => 'darkblue', -font => "helvetica 11 bold") -> pack ();
$myframeCPU3Gov -> pack (-side => 'left');
$myframeCPU3Gov -> pack (-padx => 10, -pady => 10);


# Create CPU Frequency Sub Window
$myframeFrequency = $WinMain -> Frame (-relief => 'groove', -bd => 5);
$myframeFrequency -> Label (-text => 'CPU Frequencies', -font => "helvetica 12 bold") -> pack ();
$myframeFrequency -> pack (-side => 'top');
$myframeFrequency -> pack (-padx => 10, -pady => 30);

# CPU0 Frequencies
$myframeCPU0Freq = $myframeFrequency -> Frame (-relief => 'groove', -bd => 5);
$myframeCPU0Freq -> Label (-text => 'CPU0', -font => "helvetica 12 bold") -> pack ();
$CPU0_Min_Freq = `sudo cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq`/1000;
$CPU0_Min_Label = $myframeCPU0Freq -> Label(-text => 'Minimum = '."$CPU0_Min_Freq".' MHz', -foreground => 'blue', -font => "helvetica 11 bold") -> pack ();
$CPU0_Max_Freq = `sudo cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq`/1000;
$CPU0_Max_Label = $myframeCPU0Freq -> Label (-text => 'Maximum = '."$CPU0_Max_Freq".' MHz', -foreground => 'red', -font => "helvetica 11 bold") -> pack ();
$CPU0_Oper_Label = $myframeCPU0Freq -> Label (-text => 'Operating = '."$CPU0_Oper_Freq".' MHz', -font => "helvetica 11 bold")->pack();
$CPU0_Avg_Label = $myframeCPU0Freq -> Label (-text => 'Average = '."$CPU0_Avg_Freq".' MHz', -foreground => 'purple', -font => "helvetica 11 bold")->pack();
$myframeCPU0Freq -> pack (-side => 'left');
$myframeCPU0Freq -> pack (-padx => 26, -pady => 10);

# CPU1 Frequencies
$myframeCPU1Freq = $myframeFrequency -> Frame (-relief => 'groove', -bd => 5);
$myframeCPU1Freq -> Label (-text => 'CPU1', -font => "helvetica 12 bold") -> pack ();
$CPU1_Min_Freq = `sudo cat /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_min_freq`/1000;
$CPU1_Min_Label = $myframeCPU1Freq -> Label (-text => 'Minimum = '."$CPU1_Min_Freq".' MHz', -foreground => 'blue', -font => "helvetica 11 bold") -> pack();
$CPU1_Max_Freq = `sudo cat /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_max_freq`/1000;
$CPU1_Max_Label = $myframeCPU1Freq -> Label(-text => 'Maximum = '."$CPU1_Max_Freq".' MHz', -foreground => 'red', -font => "helvetica 11 bold") -> pack ();
$CPU1_Oper_Label = $myframeCPU1Freq -> Label(-text => 'Operating = '."$CPU1_Oper_Freq".' MHz', -font => "helvetica 11 bold") -> pack ();
$CPU1_Avg_Label = $myframeCPU1Freq -> Label (-text => 'Average = '."$CPU1_Avg_Freq".' MHz', -foreground => 'purple', -font => "helvetica 11 bold")->pack();
$myframeCPU1Freq -> pack (-side => 'left');
$myframeCPU1Freq -> pack (-padx => 26, -pady => 10);

# CPU2 Frequencies
$myframeCPU2Freq = $myframeFrequency -> Frame (-relief => 'groove', -bd => 5);
$myframeCPU2Freq -> Label(-text => 'CPU2', -font => "helvetica 12 bold")->pack ();
$CPU2_Min_Freq = `sudo cat /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_min_freq`/1000;
$CPU2_Min_Label = $myframeCPU2Freq -> Label (-text => 'Minimum = '."$CPU2_Min_Freq".' MHz', -foreground => 'blue', -font => "helvetica 11 bold") -> pack();
$CPU2_Max_Freq = `sudo cat /sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_max_freq`/1000;
$CPU2_Max_Label = $myframeCPU2Freq -> Label (-text => 'Maximum = '."$CPU2_Max_Freq".' MHz', -foreground => 'red', -font => "helvetica 11 bold") -> pack();
$CPU2_Oper_Label = $myframeCPU2Freq -> Label (-text => 'Operating = '."$CPU2_Oper_Freq".' MHz', -font => "helvetica 11 bold") -> pack ();
$CPU2_Avg_Label = $myframeCPU2Freq -> Label (-text => 'Average = '."$CPU2_Avg_Freq".' MHz', -foreground => 'purple', -font => "helvetica 11 bold") -> pack();
$myframeCPU2Freq -> pack (-side => 'left');
$myframeCPU2Freq -> pack (-padx => 26, -pady => 10);

# CPU3 Frequencies
$myframeCPU3Freq =$myframeFrequency -> Frame (-relief => 'groove', -bd => 5);
$myframeCPU3Freq -> Label(-text => 'CPU3', -font => "helvetica 12 bold")->pack ();
$CPU3_Min_Freq = `sudo cat /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_min_freq`/1000;
$CPU3_Min_Label = $myframeCPU3Freq->Label(-text => 'Minimum = '."$CPU3_Min_Freq".' MHz', -foreground => 'blue', -font => "helvetica 11 bold") -> pack();
$CPU3_Max_Freq = `sudo cat /sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_max_freq`/1000;
$CPU3_Max_Label = $myframeCPU3Freq->Label(-text => 'Maximum = '."$CPU3_Max_Freq".' MHz', -foreground => 'red', -font => "helvetica 11 bold") -> pack();
$CPU3_Oper_Label = $myframeCPU3Freq->Label(-text => 'Operating = '."$CPU3_Oper_Freq".' MHz', -font => "helvetica 11 bold") -> pack();
$CPU3_Avg_Label = $myframeCPU3Freq -> Label (-text => 'Average = '."$CPU3_Avg_Freq".' MHz', -foreground => 'purple', -font => "helvetica 11 bold") -> pack();
$myframeCPU3Freq -> pack (-side => 'left');
$myframeCPU3Freq -> pack (-padx => 26, -pady => 10);


################################# Call Subroutines ###################################

$WinMain -> repeat(1000, \&GetUptime);

$WinMain -> repeat(1000, \&GetCPUTemp);

$WinMain -> repeat(1000, \&GetSSDTemp);

$WinMain -> repeat(1000, \&GetCPUGov);

$WinMain -> repeat(1000, \&GetCPUFreq);


MainLoop();


#################################### Subroutines #####################################

###################################### UpTime #######################################

sub GetUptime {

# Read Uptime String
$Uptime_String = `cat /proc/uptime`;

# Store Uptime Into Array
@Uptime_Array = split ' ', $Uptime_String;

# Export Uptime Array Element as Variable
$Uptime = int ($Uptime_Array[0]);

# Compute Hours
$Uptime_Hours = int ($Uptime / 3600);
$Uptime = $Uptime % 3600;

# Compute Minutes
$Uptime_Minutes = int ($Uptime / 60);
$Uptime = $Uptime % 60;

# Compute Seconds
$Uptime_Seconds = $Uptime;
$Uptime_Label -> configure (-text => "$Uptime_Hours".':'."$Uptime_Minutes".':'."$Uptime_Seconds".'(hr:min:sec)');

}

################################ CPU Temperature Data ################################

sub GetCPUTemp {

$CPU_Temp_Unfiltered1 = `sudo sensors`;

# Read Unfiltered CPU Temperature Data Into Array
@CPU_Temp_Array1 = split ' ', $CPU_Temp_Unfiltered1;

# Read CPU Temp Out Of Array - 4th Element
$CPU_Temp_Unfiltered2 = $CPU_Temp_Array1[5];

# Capture Only Numbers From String
@CPU_Temp_Array2 = split '°', $CPU_Temp_Unfiltered2;

$CPU_Temp = $CPU_Temp_Array2[0];

$CPU_Temp_Label -> configure (-text => $CPU_Temp.' Deg. C.'); 

}

################################ SSD Temperature Data ################################

sub GetSSDTemp {

$SSD_Temp_Unfiltered1 = `sudo hddtemp /dev/sda`;

# Read Unfiltered SSD Temperature Data Into Array
@SSD_Temp_Array1 = split ' ', $SSD_Temp_Unfiltered1;

# Read SSD Temp Out Of Array - 4th Element
$SSD_Temp_Unfiltered2 = $SSD_Temp_Array1[3];

# Capture Only Numbers From String
@SSD_Temp_Array2 = split '°', $SSD_Temp_Unfiltered2;

$SSD_Temp = $SSD_Temp_Array2[0];

$SSD_Temp_Label -> configure (-text => $SSD_Temp.' Deg. C.');

}


############################## CPU Frequency Governor Data ###############################

sub GetCPUGov {


# Read Active CPU0 Governor
$CPU0_Gov = `sudo cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor`;
$CPU0_Gov_Label -> configure (-text => "$CPU0_Gov");

# Read Active CPU0 Governor
$CPU1_Gov = `sudo cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor`;
$CPU1_Gov_Label -> configure (-text => "$CPU1_Gov");

# Read Active CPU0 Governor
$CPU2_Gov = `sudo cat /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor`;
$CPU2_Gov_Label -> configure (-text => "$CPU2_Gov");

# Read Active CPU0 Governor
$CPU3_Gov = `sudo cat /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor`;
$CPU3_Gov_Label -> configure (-text => "$CPU3_Gov");

}



################################## CPU Frequency Data ####################################

sub GetCPUFreq {

########################################## CPU0 ##########################################

# Read Current CPU0 Operating Frequency
$CPU0_Oper_Freq = `sudo cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq`/1000;
$CPU0_Oper_Label -> configure (-text => 'Operating = '."$CPU0_Oper_Freq".' MHz');

# Read Time CPU0 Spends at Each Processor Frequency
$CPU0_Time_In_State = `sudo cat /sys/devices/system/cpu/cpu0/cpufreq/stats/time_in_state`;

# Store CPU0 Time at Each Processor Frequency Into Array
@CPU0_Time_Array = split ' ', $CPU0_Time_In_State;

# Export CPU0 Array Elements as Variables
$CPU0_Freq1 = $CPU0_Time_Array[0];
$CPU0_Ticks1 = $CPU0_Time_Array[1];
$CPU0_Freq2 = $CPU0_Time_Array[2];
$CPU0_Ticks2 = $CPU0_Time_Array[3];


# Compute Average Frequency of CPU0
$CPU0_Avg_Freq = sprintf ("%.1f" , ((($CPU0_Freq1 * $CPU0_Ticks1) + ($CPU0_Freq2 * $CPU0_Ticks2)) / ($CPU0_Ticks1 + $CPU0_Ticks2) / 1000));
$CPU0_Avg_Label -> configure (-text => 'Average = '."$CPU0_Avg_Freq".' MHz');

########################################### CPU1 #########################################

# Read Current CPU1 Operating Frequency
$CPU1_Oper_Freq = `sudo cat /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq`/1000;
$CPU1_Oper_Label -> configure (-text => 'Operating = '."$CPU1_Oper_Freq".' MHz');

# Read Time CPU1 Spends at Each Processor Frequency
$CPU1_Time_In_State = `sudo cat /sys/devices/system/cpu/cpu1/cpufreq/stats/time_in_state`;

# Store CPU1 Time at Each Processor Frequency Into Array
@CPU1_Time_Array = split ' ', $CPU1_Time_In_State;

# Export CPU1 Array Elements as Variables
$CPU1_Freq1 = $CPU1_Time_Array[0];
$CPU1_Ticks1 = $CPU1_Time_Array[1];
$CPU1_Freq2 = $CPU1_Time_Array[2];
$CPU1_Ticks2 = $CPU1_Time_Array[3];

# Compute Average Frequency of CPU1
$CPU1_Avg_Freq = sprintf ("%.1f" , ((($CPU1_Freq1 * $CPU1_Ticks1) + ($CPU1_Freq2 * $CPU1_Ticks2)) / ($CPU1_Ticks1 + $CPU1_Ticks2) / 1000));
$CPU1_Avg_Label -> configure (-text => 'Average = '."$CPU1_Avg_Freq".' MHz');


########################################### CPU2 ########################################

# Read Current CPU2 Operating Frequency
$CPU2_Oper_Freq = `sudo cat /sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_cur_freq`/1000;
$CPU2_Oper_Label -> configure (-text => 'Operating = '."$CPU2_Oper_Freq".' MHz');

# Read Time CPU2 Spends at Each Processor Frequency
$CPU2_Time_In_State = `sudo cat /sys/devices/system/cpu/cpu2/cpufreq/stats/time_in_state`;

# Store CPU2 Time at Each Processor Frequency Into Array
@CPU2_Time_Array = split ' ', $CPU2_Time_In_State;

# Export CPU2 Array Elements as Variables
$CPU2_Freq1 = $CPU2_Time_Array[0];
$CPU2_Ticks1 = $CPU2_Time_Array[1];
$CPU2_Freq2 = $CPU2_Time_Array[2];
$CPU2_Ticks2 = $CPU2_Time_Array[3];

# Compute Average Frequency of CPU2
$CPU2_Avg_Freq = sprintf ("%.1f" , ((($CPU2_Freq1 * $CPU2_Ticks1) + ($CPU2_Freq2 * $CPU2_Ticks2)) / ($CPU2_Ticks1 + $CPU2_Ticks2) / 1000));
$CPU2_Avg_Label -> configure (-text => 'Average = '."$CPU2_Avg_Freq".' MHz');


####################################### CPU3 ########################################

# Read Current CPU3 Operating Frequency
$CPU3_Oper_Freq = `sudo cat /sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_cur_freq`/1000;
$CPU3_Oper_Label -> configure (-text => 'Operating = '."$CPU3_Oper_Freq".' MHz');

# Read Time CPU3 Spends at Each Processor Frequency
$CPU3_Time_In_State = `sudo cat /sys/devices/system/cpu/cpu3/cpufreq/stats/time_in_state`;

# Store CPU3 Time at Each Processor Frequency Into Array
@CPU3_Time_Array = split ' ', $CPU3_Time_In_State;

# Export CPU3 Array Elements as Variables
$CPU3_Freq1 = $CPU3_Time_Array[0];
$CPU3_Ticks1 = $CPU3_Time_Array[1];
$CPU3_Freq2 = $CPU3_Time_Array[2];
$CPU3_Ticks2 = $CPU3_Time_Array[3];

# Compute Average Frequency of CPU3
$CPU3_Avg_Freq = sprintf ("%.1f" , ((($CPU3_Freq1 * $CPU3_Ticks1) + ($CPU3_Freq2 * $CPU3_Ticks2)) / ($CPU3_Ticks1 + $CPU3_Ticks2) / 1000));
$CPU3_Avg_Label -> configure (-text => 'Average = '."$CPU3_Avg_Freq".' MHz');

}
