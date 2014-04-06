{extends designs/site.tpl}

{block title}Objavljena novost &mdash; {$dwoo.parent}{/block}

{block content}
    <p><a href="/projects/{$data->Project->Handle}/updates/{$data->Number}">Novost #{$data->Number}</a> je objavljena u projektu {projectLink $data->Project}</p>
{/block}
