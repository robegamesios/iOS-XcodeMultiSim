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

c. Open Run destinations Cmd+Shift+2 then do the following:
  a. Select Simulators and click (+) to add a new run destination
  b. Name the simulator `iPhone15+MultiSim` or anything you like. You will need this name later
  c. Select iPhone 15 for the Device Type
  d. Click `Create`


![Screenshot 2024-08-31 at 1 44 09 PM](https://github.com/user-attachments/assets/e99a24f1-9b85-44ea-ba20-d548aa41b3cc)

d. Go to Project Navigator, then select the Project, then select the Target.
   1. In Build Phases tab, add a new Run Script and paste the code below.

```
custom_sim=`xcrun simctl list | grep 'iPhone15+MultiSim' | awk -F'[()]' '{print $2}'`
if [ ! -z "${custom_sim}" ] && [ "${TARGET_DEVICE_IDENTIFIER}" = "${custom_sim}" ]; then
/bin/sh buildAndRunMultipleSimulators.sh
fi
```
    
   1. If you named your simulator something else, then update the name in the script (`grep 'iPhone15+MultiSim'`).
      
   2. You can also rename the run script

![Screenshot 2024-08-31 at 1 45 54 PM](https://github.com/user-attachments/assets/2d679211-2c87-4a91-9a1d-b555c8625f6f)

   
e. Select iPhone15+MultiSim as your simulator and run the project.  
