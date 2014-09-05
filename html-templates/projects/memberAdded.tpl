{extends designs/site.tpl}

{block title}{_ "Members"} &mdash; {$dwoo.parent}{/block}

{block content}
    {capture assign=person}{personLink $Member} {if $data->Role}({$data->Role|escape}){/if}{/capture}
    {capture assign=project}{projectLink $Project}{/capture}

    <p>{sprintf(_("%s has been added to %s"), $person, $project)}</p>
{/block}