<?php
define('WMF_UNSUB_SALT', 'docker');

$dbs = array(
  'civicrm' => array('civicrm', 'root', 'dockerpass'),
  # FIXME: Separate database not correctly supported by the contribution_tracking installer...
  'default' => array('drupal', 'root', 'dockerpass'),
  'donations' => array('drupal', 'root', 'dockerpass'),
  'fredge' => array('fredge', 'root', 'dockerpass'),
  'smashpig' => array('smashpig', 'root', 'dockerpass'),

);
foreach ($dbs as $key => $db_config) {
  list($db, $user, $pass) = $db_config;
  $databases[$key]['default'] = array(
    'driver' => 'mysql',
    'database' => $db,
    'username' => $user,
    'password' => $pass,
    'host' => 'database', // FIXME: Use socket
    'prefix' => '',
  );
}

# default settings for drupal variable_get

$conf['environment_indicator_enabled'] = '1';

$conf['environment_indicator_text'] = 'DEVELOPMENT';

$conf['environment_indicator_position'] = 'left';

$conf['environment_indicator_color'] = '#3FBF57';

$conf['amazon_audit_log_search_past_days'] = '7';

$conf['amazon_audit_recon_completed_dir'] = '/var/spool/audit/amazon/completed';

$conf['amazon_audit_recon_files_dir'] = '/var/spool/audit/amazon/incoming/';

$conf['amazon_audit_working_log_dir'] = '/tmp/amazon_audit/';

$conf['astropay_audit_log_search_past_days'] = '7';

$conf['astropay_audit_recon_completed_dir'] = '/var/spool/audit/astropay/completed';

$conf['astropay_audit_recon_files_dir'] = '/var/spool/audit/astropay/incoming/';

$conf['astropay_audit_working_log_dir'] = '/tmp/astropay_audit/';

$conf['banner_history_queue'] = 'banner-history';

$conf['fredge_payments_antifraud_queue'] = 'payments-antifraud';

$conf['fredge_payments_init_queue'] = 'payments-init';

$conf['queue2civicrm_batch'] = '5';

$conf['queue2civicrm_batch_time'] = '90';

$conf['queue2civicrm_gateways_to_monitor'] = 'adyen,amazon,astropay,globalcollect,paypal';

$conf['queue2civicrm_gmetric_dmax'] = '360';

$conf['queue2civicrm_gmetric_tmax'] = '60';

$conf['recurring_globalcollect_batch'] = '1';

$conf['recurring_globalcollect_batch_max'] = '100';

$conf['recurring_globalcollect_failure_retry_rate'] = '1';

$conf['recurring_globalcollect_failures_before_cancellation'] = '3';

$conf['recurring_globalcollect_run_missed_days'] = '7';

$conf['refund_batch'] = '0';

$conf['refund_batch_time'] = '90';

$conf['thank_you_days'] = '14';

$conf['thank_you_batch'] = '100';

$conf['https'] = TRUE;


# TODO: Move to civicrm.settings.php and use CIVICRM_UF_BASEURL constant
global $civicrm_setting;
$civicrm_setting['URL Preferences']['userFrameworkResourceURL'] = 'https://localhost:8002/sites/all/modules/civicrm';

# FIXME: That's annoying.
require_once __DIR__ . '/../../vendor/autoload.php';

require_once __DIR__ . '/DonationInterface.settings.php';

# Include local overrides.
if (file_exists(__DIR__ . '/settings.local.php')) {
  require_once __DIR__ . '/settings.local.php';
}
