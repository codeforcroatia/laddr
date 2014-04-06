{extends designs/site.tpl}

{block title}Ažuriranja projekata &mdash; {$dwoo.parent}{/block}
{block content}
    <h2>
        Ažuriranja projekata
        {if $Project}
            u <a href="/projects/{$Project->Handle}">{$Project->Title|escape}</a>
        {/if}
    </h2>

    {foreach item=Update from=$data}
        {projectUpdate $Update headingLevel=h3 showProject=true}
    {/foreach}

{/block}
