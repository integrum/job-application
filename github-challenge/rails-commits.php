<?php
	$url = "http://github.com/api/v2/json/commits/list/rails/rails/master";
	$json = json_decode(file_get_contents($url));
	$data = array();
	foreach ($json->commits as $commit) {
		$data[$commit->author->email][] = $commit;
	}
	ksort($data);
?>
<? foreach ($data as $email => $commits): ?> 
<h1><?= $commits[0]->author->name . " (" . $email . ")"?></h1>	
<ul>
	<? foreach ($commits as $commit): ?>
	<li><tt><?= $commit->id ?></tt><br/><?= $commit->message ?></li>
	<? endforeach ?>		
</ul>
</pre>
<? endforeach ?>		