# Symantec Virus Definition Scanner

See http://uptimesoftware.github.io for more information.

### Tags 
 plugin   security   virus   symantec  

### Category

plugin

### Version Compatibility


  
* Symantec Virus Definition Monitor 1.1 - 7.1, 7.0, 6.0, 5.5, 5.4, 5.3.x Windows, 5.3.x Linux/Solaris, 5.3, 5.2
* Symantec Virus Definition Monitor 2.0 - 7.3,7.4,7.5,7.6 


### Description
This plugin monitor is designed to monitor Symantec Anti-Virus Virus Definition files. Users specify the directory where the XDB files are and the monitor will decode the filename of the latest XDB file. It outputs when the virus definition was last updated and how many days has it been since the last update.


### Supported Monitoring Stations

7.4,7.5,7.67.3, 7.1, 7.0, 6.0, 5.5, 5.4, 5.3.x Windows, 5.3.x Linux/Solaris, 5.3, 5.2

### Supported Agents
None; no agent required

### Installation Notes
<p><a href="https://github.com/uptimesoftware/uptime-plugin-manager">Install using the up.time Plugin Manager</a>
On the Windows hosts where monitoring of the virus definition is required:</p>

<ol>
<li><p>Install an up.time agent. See this KB article</p></li>
<li><p>Download and unzip MonitorSymantecVirusDefinition-vx.x-agent-files.zip</p></li>
<li><p>Place the monitor-virus-def.vbs file in the uptime agent directory in a subdirectory called "scripts" (C:\Program Files\uptime software\up.time agent\scripts)
(create the scripts directory if needed)</p></li>
<li><p>Open the uptime Agent Console (Start > up.time agent > uptime Agent Console)</p></li>
<li><p>Make sure you know what the value is in the Password field. Otherwise, set it to something you remember (e.g. uptime)</p></li>
<li><p>Click on Advanced > Custom Scripts</p></li>
<li><p>Enter the following:</p></li>
</ol>


<p>Command Name: virusdef
Path to Script: cmd.exe /c "cscript.exe /nologo "C:\Program Files\uptime software\up.time agent\scripts\monitor-virus-def.vbs""</p>

<p>Note: Depending on where you put the vbs script in step 2, the "Path to Script" value might be different</p>


### Dependencies
<p>n/a</p>


### Input Variables

* Script Name - the location of the script on the monitoring station that contains the logic for contacting the agent and returning the output in a useful format to the monitoring station. The default value should work in most cases.

* Port - port that the up.time agent is listening on (default 9998)

* Password - password that the up.time agent has setup

* Virus Definition Directory - the full path location of the XDB files on the agent system that is to be monitored (e.g. C:\Program Files\SAV)


### Output Variables


* Days Since Last Update

* Last Update Date


### Languages Used

* Shell/Batch

* VBScript

