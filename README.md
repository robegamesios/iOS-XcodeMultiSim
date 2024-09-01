# iOS-XcodeMultiSim
Build once and run multiple Simulators in Xcode or CLI.
Tested on Xcode 15.4

Youtube video: https://youtu.be/rEm9NqzoHE0?si=eKRU5rLv8cHNA3i4

# STEPS
a. Copy the script file `buildAndRunMultipleSimulators.sh` and paste in on your project root directory.

b. Open the script file and change the following:
  1. project name - Go to Xcode -> Settings -> Locations -> Derived Data. Your project name is before the random characters. For example in `SwiftUI-WeatherApp-fyrnhrghniuvzdcfowvoxagsnypn`, your project name is `SwiftUI-WeatherApp`.

  2. app name - Look at your project directory, your app name has extension of `.xcodeproj`
  
  3. scheme - At the top of Xcode IDE, left of the simulator name
  
  4. bundle identifier -  Go to Targets -> General, under Identity section

![Screenshot 2024-08-31 at 1 38 49 PM](https://github.com/user-attachments/assets/2265b8f4-ec7e-476a-8e60-8f184ed06f1a)

c. Edit the `buildAndRunMultipleSimulators.sh` script:
  1. Update the variables
     
  2. Update the simulators by name or identifier

<img width="898" alt="Screenshot 2024-09-01 at 8 30 17 AM" src="https://github.com/user-attachments/assets/c7bcae13-3c5a-485c-b2fe-6a92030d9923">

d. Open Run destinations Cmd+Shift+2 then do the following:
  a. Select Simulators and click (+) to add a new run destination
  b. Name the simulator `iPhone15+MultiSim` or anything you like. You will need this name later
  c. Select iPhone 15 for the Device Type
  d. Click `Create`


![Screenshot 2024-08-31 at 1 44 09 PM](https://github.com/user-attachments/assets/e99a24f1-9b85-44ea-ba20-d548aa41b3cc)

e. Go to Project Navigator, then select the Project, then select the Target.
   1. In Build Phases tab, add a new Run Script and paste the code below.

```
custom_sim=`xcrun simctl list | grep 'iPhone15+MultiSim' | awk -F'[()]' '{print $2}'`
if [ ! -z "${custom_sim}" ] && [ "${TARGET_DEVICE_IDENTIFIER}" = "${custom_sim}" ]; then
/bin/sh buildAndRunMultipleSimulators.sh
fi
```
    
   1. If you named your script to something else, then update the filename in the script
     
   2. If you named your simulator to something else, then update the name in the script (`grep 'iPhone15+MultiSim'`)
      
   3. You can also rename the run script

![Screenshot 2024-08-31 at 1 45 54 PM](https://github.com/user-attachments/assets/076ff657-77a5-4c2c-a514-de3028c1ac97)

   
f. Select iPhone15+MultiSim as your simulator and run the project.  
