<?php
$wmvActiveExtensions[] = 'FundraisingEmailUnsubscribe';
$wgFundraisingEmailUnsubscribeQueueParameters = array(
    "opt-in" => array(
        "servers" => array(
            "host" => "queue",
            "port" => 6379,
            "scheme" => "tcp"
        )
    ),
    "unsubscribe" => array(
        "servers" => array(
            "host" => "queue",
            "port" => 6379,
            "scheme" => "tcp"
        )
    )
);
