{load_templates subtemplates/people.tpl}

{template projectLink Project}
    <a href="/projects/{$Project->Handle}">{$Project->Title|escape}</a>
{/template}

{template projectUpdate Update headingLevel=h4 showHeading=true showProject=false articleClass=""}
    <article class="project-update {$articleClass}">
        {if $showHeading}
            <{$headingLevel}>
                {if Laddr\ProjectUpdatesRequestHandler::checkWriteAccess($Update)}
                    <div class="btn-group pull-right">
                        <a href="{$Update->getURL()}/edit" class="btn btn-mini">Uredi</a>
                        <a href="{$Update->getURL()}/delete" class="btn btn-mini btn-warning">Obriši</a>
                    </div>
                {/if}
                {if $showProject}
                    <a href="{$Update->Project->getURL()}">{$Update->Project->Title|escape}</a>
                {/if}
                <small><a href="{$Update->Project->getURL()}/updates/{$Update->Number}">Novost #{$Update->Number}</a></small>
            </{$headingLevel}>
        {/if}
        <div class="update-body well">
            {$Update->Body|escape|markdown}
            <p class="muted"><small>Objavljeno dana {$Update->Created|date_format:"%c"} od {personLink $Update->Creator avatar=off}</small></p>
        </div>
    </article>
{/template}

{template projectMemberTitle Membership}{strip}
    {if $Membership->Role && $Membership->MemberID == $Membership->Project->MaintainerID}
        {$Membership->Role|escape} and Maintainer
    {elseif $Membership->Role}
        {$Membership->Role|escape}
    {elseif $Membership->MemberID == $Membership->Project->MaintainerID}
        Maintainer
    {else}
        Član
    {/if}
{/strip}{/template}
