<?php
// Copyright 2016 Las Venturas Playground. All rights reserved.
// Use of this source code is governed by the MIT license, a copy of which can
// be found in the LICENSE file.

$max = 20;

if ($argc < 2 || empty($argv[1]))
    die('Usage: php trace.php [filename] [max=20]' . PHP_EOL);

if ($argc > 2 && is_numeric($argv[2]))
    $max = (int) $argv[2];

$handle = @fopen($argv[1], 'r');
if (!$handle)
    die('Error: Unable to open "' . $argv[1] . '" for reading.' . PHP_EOL);

$events = new SplPriorityQueue();

while ($line = fgets($handle)) {
    list($type, $begin, $end, $data1, $data2) = explode('|', trim($line));
    $events->insert([
        'type'  => $type,
        'time'  => $end - $begin,

        'data1'  => $data1,
        'data2'  => $data2

    ], $end - $begin);
}

fclose($handle);

echo 'Found ' . $events->count() . ' events. Printing the top ' . $max . '.';
echo PHP_EOL . PHP_EOL;

$count = 0;
$types = [
    0   => 'LOAD_JAVASCRIPT_TRACE',
    1   => 'INTERCEPTED_CALLBACK_TOTAL',
    2   => 'INTERCEPTED_CALLBACK_EVENT_HANDLER',
    3   => 'TIMER_EXECUTION_TOTAL',
    4   => 'MYSQL_QUERY_START',
    5   => 'MYSQL_QUERY_RESOLVE',
    6   => 'MYSQL_QUERY_RESOLVE',
    7   => 'MYSQL_QUERY_REJECT'
];

foreach ($events as $event) {
    if ($count++ >= $max)
        break;

    $type = array_key_exists($event['type'], $types) ? $types[$event['type']]
                                                     : 'UNKNOWN';

    echo $type . ' - ' . round($event['time'], 2) . 'ms';
    if (strlen($event['data1']))
        echo ' - ' . $event['data1'];
    if (strlen($event['data2']))
        echo ' - ' . $event['data2'];

    echo PHP_EOL;
}

echo PHP_EOL;
