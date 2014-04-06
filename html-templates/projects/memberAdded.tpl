{extends designs/site.tpl}

{block title}Članovi &mdash; {$dwoo.parent}{/block}

{block content}
    <p>{personLink $Member} {if $data->Role}({$data->Role|escape}){/if} je dodan u projekt {projectLink $Project}</p>
{/block}
