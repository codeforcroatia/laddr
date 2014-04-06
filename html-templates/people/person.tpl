{extends "designs/site.tpl"}

{block "title"}Profil: {$data->FullName} &mdash; {$dwoo.parent}{/block}


{block "content"}
    {$Person = $data}

    <article class="member-profile">
        {avatar $Person size=200}
        <h2 class="run-in">{$Person->FullName|escape} {if $.User && $Person->ID == $.User->ID}<a href="/profile">uredi svoj profil</a>{/if}</h2>

        {if $Person->Location}
            <p class="location"><a href="http://maps.google.com/?q={$Person->Location|escape}" target="_blank">{$Person->Location|escape}</a></p>
        {/if}

        <h3>Zadnji put viđen</h3>
        <p>{tif $Person->LastCheckin ? $Person->LastCheckin->OutTime|date_format:'%c' : "Nikada"}</p>

        {if $Person->About}
            <h3>O meni</h3>
            <section class="about">
                {$Person->About|escape|markdown}
            </section>
        {/if}

        {* Only logged-in users can view contact information *}
        {if $.User}
            <h3>Kontakt informacije</h3>
            <dl>
                {if $Person->Email}
                    <dt>Email</dt>
                    <dd><a href="mailto:{$Person->EmailRecipient|escape:url}" title="Email {$Person->FullName|escape}">{$Person->Email|escape}</a></dd>
                {/if}

                {if $Person->Twitter}
                    <dt>Twitter</dt>
                    <dd><a href="https://twitter.com/{$Person->Twitter|escape}">{$Person->Twitter|escape}</a></dd>
                {/if}

                {if $Person->Phone}
                    <dt>Phone</dt>
                    <dd><a href="tel:{$Person->Phone}" target="_blank">{$Person->Phone|phone}</a></dd>
                {/if}
            </dl>

            {if $Person->ProjectMemberships}
                <dt> Moji projekti </dt>
                {foreach item=Membership from=$Person->ProjectMemberships}
                    <li><a href="{$Membership->Project->getURL()}">{$Membership->Project->Title|escape}</a> &mdash; {projectMemberTitle $Membership}</li>
                {/foreach}
            {/if}
        {/if}
    </article>

{/block}
