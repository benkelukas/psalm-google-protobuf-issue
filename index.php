<?php declare(strict_types=1);

$t = (new \Google\Protobuf\Timestamp())->setSeconds(0)->setNanos(0);

echo $t->getSeconds();
