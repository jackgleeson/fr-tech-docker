<?php
// Leave this bit alone. It pulls in the public & private settings files
// The paths below are relative to the docker container
foreach (
  array_merge(
    glob('/docker/config/mw/public/*.php'),
    glob('/docker/config/mw/private/*.php')
  ) as $config_file) {
    include_once $config_file;
}
//// Ok, you can add you own custom settings below this line :)

//Show the debug toolbar if 'debug' is set on the request
if (!empty($_REQUEST['debug'])) {
  $wgDebugToolbar = true;
}

// Expose debug info for SQL errors.
$wgDebugDumpSql = false;
$wgShowDBErrorBacktrace = true;
$wgShowSQLErrors = false;

// Disable RL caching that interferes with debugging
$wgResourceLoaderStorageEnabled = false;

// logo
$wgLogos = [ '1x' => $wgScriptPath ."/images/e/eb/Wmf_logo.png" ];

