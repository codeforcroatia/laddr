{extends designs/site.tpl}

{block title}Spremljen {$data->Title|escape} &mdash; Projekt &mdash; {$dwoo.parent}{/block}

{block content}
    {$Project = $data}

    {if $Project->isNew}
        <p>Tvoj projekt je kreiran: {projectLink $Project}</p>
    {else}
        <p>Tvoje promjene na projektu {projectLink $Project} su spremljene.</p>
    {/if}
{/block}
