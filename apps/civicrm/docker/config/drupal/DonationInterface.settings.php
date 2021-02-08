<?php
# This file is managed by Puppet. Edit settings.local.php if you want to make
# local changes.

global
	$wgDonationInterfaceDefaultQueueServer,
	$wgDonationInterfaceQueues,
	$wgDonationInterfaceEnableQueue,
	$wgDonationInterfaceQueueMirrors,
	$wgDonationInterfaceOrphanCron,
	$wgDonationInterfaceGatewayAdapters,
	$wgDonationInterfaceForbiddenCountries,
	$wgDonationInterface3DSRules,
	$wgGlobalCollectGatewayEnabled,
	$wgGlobalCollectOrphanGatewayEnabled,
	$wgGlobalCollectGatewayAccountInfo,
	$wgGlobalCollectGatewayURL,
	$wgDonationInterfacePriceFloor,
	$wgDonationInterfacePriceCeiling,
	$wgDonationInterfaceRetryLoopCount,
	$wgDonationInterfaceEnableCustomFilters,
	$wgDonationInterfaceEnableMinfraud,
	$wgDonationInterfaceEnableReferrerFilter,
	$wgDonationInterfaceEnableSourceFilter,
	$wgDonationInterfaceEnableFunctionsFilter,
	$wgDonationInterfaceEnableIPVelocityFilter,
	$wgDonationInterfaceEnableSessionVelocityFilter,
	$wgGlobalCollectGatewayCustomFiltersFunctions,
	$wgDonationInterfaceCustomFiltersActionRanges,
	$wgGlobalCollectGatewayCvvMap,
	$wgGlobalCollectGatewayAvsMap;

$wgDonationInterfaceDefaultQueueServer = array(
        'type' => 'PHPQueue\Backend\Predis',
        'servers' => array(
                'scheme' => 'tcp',
                'host' => 'localhost',
                'port' => 6379,
        ),
);

$wgDonationInterfaceQueues = array(
        'complete' => array(
                'queue' => 'donations'
        ),
);

$wgDonationInterfaceEnableQueue = true;

#Orphan Rectifying vars
$wgDonationInterfaceOrphanCron = array(
  'target_execute_time' => 300,
  // 20 minutes, the default.
  'time_buffer' => 1200,
);

$wgDonationInterfaceGatewayAdapters = array(
    'globalcollect' => 'GlobalCollectAdapter',
    'globalcollect_orphan' => 'GlobalCollectOrphanAdapter',
);

$wgDonationInterfaceForbiddenCountries = array(
	'XX', // For testing
);

$wgDonationInterface3DSRules = array();

$wgGlobalCollectGatewayEnabled = true;
$wgGlobalCollectOrphanGatewayEnabled = true;

# Ingenico (GlobalCollect)
$wgGlobalCollectGatewayAccountInfo['test'] = array(
        'MerchantID' => '1234',
);

$wgGlobalCollectGatewayURL = 'https://ps.gcsip.nl/wdl/wdl';

$wgDonationInterfacePriceFloor = 1;

$wgDonationInterfacePriceCeiling = 10000;

$wgDonationInterfaceRetryLoopCount = 3;

// Fraud configuration
$wgDonationInterfaceEnableCustomFilters = true;
$wgDonationInterfaceEnableMinfraud = false;
$wgDonationInterfaceEnableReferrerFilter = true;
$wgDonationInterfaceEnableSourceFilter = true;
$wgDonationInterfaceEnableFunctionsFilter = true;
// Not used for offline charges.
$wgDonationInterfaceEnableIPVelocityFilter = false;
$wgDonationInterfaceEnableSessionVelocityFilter = false;

$wgGlobalCollectGatewayCustomFiltersFunctions = array(
  'getCVVResult' => 1,
  'getAVSResult' => 3,
  'getScoreCountryMap' => 5,
  'getScoreUtmCampaignMap' => 7,
  'getScoreEmailDomainMap' => 11,
);

$wgDonationInterfaceCustomFiltersActionRanges = array(
	"process" => array(
		0,
		100,
	),
	"review" => array(
		-1,
		-1,
	),
	"challenge" => array(
		-1,
		-1,
	),
	"reject" => array(
		-1,
		-1,
	),
);

$wgGlobalCollectGatewayCvvMap = array(
	"M" => true,
	"N" => false,
	"P" => true,
	"S" => false,
	"U" => true,
	"Y" => false,
	"0" => true,
	"" => false,
);

$wgGlobalCollectGatewayAvsMap = array(
	"A" => 50,
	"B" => 50,
	"C" => 50,
	"D" => 0,
	"E" => 100,
	"F" => 0,
	"G" => 50,
	"I" => 50,
	"M" => 0,
	"N" => 100,
	"P" => 50,
	"R" => 100,
	"S" => 50,
	"U" => 50,
	"W" => 50,
	"X" => 0,
	"Y" => 0,
	"Z" => 50,
	"0" => 25,
	"" => 100,
);
