<?php

require('rcs_function.php');

// get all the variables from the environmental variable
$dir            = getenv('UPTIME_DIR');
$agent_hostname = getenv('UPTIME_HOSTNAME');
$agent_port     = getenv('UPTIME_PORT');
$agent_password = getenv('UPTIME_PASSWORD');

$cmdlinevar = '';	// create the one variable for the command line and parse from the main 4 variables

// "contains()" function
// http://www.jonasjohn.de/snippets/php/contains.htm
function contains($str, $content, $ignorecase=true){
    if ($ignorecase){
        $str = strtolower($str);
        $content = strtolower($content);
    }  
    return strpos($str,$content) ? true : false;
}


// determine if the agent is a Windows or other (posix) agent since the Windows agent requires special handling
function is_agent($veroutput, $agenttype) {
	$rv = 0;
	// check if the agent is on Windows or anything else (Posix)
	if (contains($veroutput, $agenttype, true)) {
		$rv = 1;
	}
	if (strlen($veroutput) == 0) {
		$rv = 0;
		print "Error: no lines returned from 'ver'. Is the agent running?";
		exit(1);
	}
	return $rv;
}

$dir = str_replace(' ', "UPSPCTIME", $dir);
$cmdlinevar = $dir;

// depending on the platform (Windows/Others) the command for the remote agent script will be different
$veroutput = agentcmd($agent_hostname, $agent_port, "ver");
if (is_agent($veroutput, "windows")) {
	$cmd = "virusdef";
}
elseif (is_agent($veroutput, "solaris")) {
	$cmd = "/opt/uptime-agent/scripts/log_monitor.pl";
}
elseif (is_agent($veroutput, "linux")) {
	$cmd = "/opt/uptime-agent/scripts/log_monitor.pl";
}
elseif (is_agent($veroutput, "aix")) {
	$cmd = "/opt/uptime-agent/scripts/log_monitor.pl";
}
else {
	$cmd = "/opt/uptime-agent/scripts/log_monitor.pl";
	//print "Unknown agent? '{$veroutput}'";
	//exit(1);
}

$agent_output = uptime_remote_custom_monitor($agent_hostname, $agent_port, $agent_password, $cmd, $cmdlinevar);
if (strlen($agent_output) == 0) {
	print "Error: No lines returned from agent.";
	exit(1);
}
if ($agent_output == "ERR\n") {
	print "Error: Output received: 'ERR'. The agent may not be configured correctly. Check the password?";
	exit(2);
}

print $agent_output;
if (strpos($agent_output,'No XDB file found') !== false) {
    exit(2);
} else {
    exit(0);
}

?>