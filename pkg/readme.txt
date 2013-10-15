
1. About
-------------------------
This plugin monitor is designed to monitor Symantec Anti-Virus Virus Definition files.  Users specify the directory where the XDB files are and the monitor will decode the filename of the latest XDB file.  It outputs when the virus definition was last updated and how many days has it been since the last update.

Below is a description of each of the parameters used by the monitor:

 Script Name   - the location of the script on the monitoring station that
                 contains the logic for contacting the agent and returning
                 the output in a useful format to the monitoring station.
		 The default value should work in most cases.
	

 Port          - port that the up.time agent is listening on (default 9998)

 Password      - password that the up.time agent has setup


 Virus Definition Directory - the full path location of the XDB fileson the agent system
        	              that is to be monitored
			      e.g. C:\Program Files\SAV


2. Agent Installation
-------------------------
On the Windows hosts where monitoring of the virus definition is required:

1. Install an up.time agent.  See: http://support.uptimesoftware.com/article.php?id=079

2. Download and unzip MonitorSymantecVirusDefinition-vx.x-agent-files.zip

3. Place the monitor-virus-def.vbs file in the uptime agent directory in a subdirectory called "scripts" (C:\Program Files\uptime software\up.time agent\scripts)
   (create the scripts directory if needed)

4. Open the uptime Agent Console (Start > up.time agent > uptime Agent Console) 

5. Make sure you know what the value is in the Password field.  Otherwise, set it to something you remember (e.g. uptime)

6. Click on Advanced > Custom Scripts

7. Enter the following:

     Command Name: virusdef
     Path to Script: cmd.exe /c "cscript.exe  /nologo "C:\Program Files\uptime software\up.time agent\scripts\monitor-virus-def.vbs""

   Note: Depending on where you put the vbs script in step 2, the "Path to Script" value might be different

