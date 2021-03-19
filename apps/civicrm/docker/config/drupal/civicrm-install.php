<?php

$config = array(
    'site_dir' => 'default',
    'base_url' => 'https://localhost:8002/',
    'mysql' => array(
        'username' => 'root',
        'password' => 'dockerpass',
        'server' => 'database',
        'database' => 'civicrm',
    ),
    'drupal' => array(
        'username' => 'root',
        'password' => 'dockerpass',
        'server' => 'database',
        'database' => 'drupal',
    ),
);

global $cmsPath, $crmPath, $installType;
$cmsPath = '/var/www/html/drupal';
$crmPath = '/var/www/html/civicrm';
$installType = 'drupal';

define( 'VERSION', '7.0' );
define( 'DB_USER', $config['drupal']['username'] );
define( 'DB_PASSWORD', $config['drupal']['password'] );
define( 'DB_HOST', $config['drupal']['server'] );
define( 'DB_NAME', $config['drupal']['database'] );

require_once '/var/www/html/civicrm/install/civicrm.php';

civicrm_main( $config );
$extDir = '/var/www/html/drupal/sites/default/civicrm/extensions';
$extUrl = 'https://localhost:8002/sites/default/civicrm/extensions';
file_put_contents('/var/www/html/drupal/sites/default/civicrm.settings.php', "
global \$civicrm_setting;
\$civicrm_setting['Directory Preferences']['extensionsDir'] = '$extDir';
\$civicrm_setting['URL Preferences']['extensionsURL'] = '$extUrl';
\$civicrm_root = '$cmsPath/sites/all/modules/civicrm';",
FILE_APPEND
);
