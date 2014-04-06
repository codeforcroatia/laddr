{extends designs/site.tpl}

{block title}{$data->Title|escape} &mdash; Projekt &mdash; {$dwoo.parent}{/block}

{block content}
    {$Project = $data}

    <h2>
        {$Project->Title|escape}
        <div class="btn-group pull-right">
            <a href="/projects/{$Project->Handle}/edit" class="btn btn-info">Uredi projekt</a>
            <button class="btn btn-info dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
            <ul class="dropdown-menu">
                <li><a href="#add-member" data-toggle="modal">Dodaj člana</a></li>
                {if $.User && ($Project->hasMember($.User) || $.Session->hasAccountLevel('Staff'))}
                    <li><a href="#post-update" data-toggle="modal">Napiši novosti</a></li>
                {/if}
                {if $.Session->hasAccountLevel('Staff')}
                    <li><a href="#manage-members" data-toggle="modal">Uredi članove</a></li>
                {/if}
            </ul>
        </div>
    </h2>

    <div class="row-fluid">
        <article class="project span8">
            <h3>Informacije o projektu</h3>
            <dl class="dl-horizontal">
                {if $Project->UsersUrl}
                    <dt>Link za korisnike</dt>
                    <dd><a href="{$Project->UsersUrl|escape}">{$Project->UsersUrl|escape}</a></dd>
                {/if}

                {if $Project->DevelopersUrl}
                    <dt>Link za developere</dt>
                    <dd><a href="{$Project->DevelopersUrl|escape}">{$Project->DevelopersUrl|escape}</a></dd>
                {/if}

                {if $Project->README}
                    <dt>Opis projekta</dt>
                    <dd class="markdown readme well">{$Project->README|escape|markdown}</dd>
                {/if}

                {*
                <dt>Komentari: </dt>
                <dd>
                    <form method="post" action="/projects/{$Project->Handle}/comment">
                    <textarea name="Message"></textarea>
                    <input type="submit" value="Pošalji">
                    </form>
                </dd>
                {foreach item=Comment from=$Project->$Comments}
                    <p>
                    {$Comment->Message}
                    </p>
                {/foreach}
                *}

            </dl>

{*
            {if ($.User && $Project->hasMember($.User))}
                <form action="/projects/{$Project->Handle}/json/create-request">
                    <button class="btn btn-success" type="submit">Trebate pomoć?&hellip;</button>
                </form>
            {/if}
*}

            {if ($.User && $Project->hasMember($.User)) || count($Project->Updates)}
                <h3>
                    Novosti o projektu
                    {if $.User && $Project->hasMember($.User)}
                        <a href="#post-update" class="btn btn-mini" data-toggle="modal">Napiši novost</a>
                    {/if}
                </h3>
            {/if}

            {if count($Project->Updates)}
                {foreach item=Update from=$Project->Updates}
                    {projectUpdate $Update}
                {/foreach}
            {/if}
        </article>

        <aside class="twitterstream span4">
            {if $Project->Memberships}
                <h3>Članovi</h3>

                <ul class="inline people-list">
                {foreach item=Membership from=$Project->Memberships}
                    {$Member = $Membership->Member}
                    <li class="listed-person {tif $Project->MaintainerID == $Member->ID ? maintainer}">
                        <a
                            href="/members/{$Member->Username}"
                            class="thumbnail member-thumbnail"
                            data-toggle="tooltip"
                            data-placement="bottom"
                            title="{$Member->FullName|escape}{if $Membership->Role}&mdash;{$Membership->Role}{/if}{if $Project->MaintainerID == $Member->ID}{tif $Membership->Role ? ' and ' : '&mdash;'}Maintainer{/if}"
                        >
                            {avatar $Member size=60}
                        </a>
                    </li>
                {foreachelse}
                    <li class="muted">Nema registriranih</li>
                {/foreach}
                    <li><a class="btn btn-success add-person" href="#add-member" data-toggle="modal">+ Dodaj</a></li>
                </ul>
            {/if}

            <hr>

            <div>
                <a class="btn btn-mini" href="{RemoteSystems\Twitter::getTweetIntentURL('Pogledaj $Project->Title!', array(url = 'http://$.server.HTTP_HOST/projects/$Project->Handle'))}">Ispričaj o projektu na Twitteru!</a>
            </div>
        </aside>
    </div>

{/block}

{block js-bottom}
    {$dwoo.parent}

    <form id="add-member" class="modal fade hide form-horizontal" action="/projects/{$Project->Handle}/add-member" method="POST">
        <header class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h3>Dodaj člana na projekt</h3>
        </header>
        <section class="modal-body">
            <div class="control-group">
                <label class="control-label" for="inputUsername">Korisničko ime</label>
                <div class="controls">
                    <input type="text" id="inputUsername" name="username" required>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="inputRole">Uloga</label>
                <div class="controls">
                    <input type="text" id="inputRole" name="role" placeholder="optional">
                </div>
            </div>
        </section>
        <footer class="modal-footer">
            <button class="btn" data-dismiss="modal" aria-hidden="true">Zatvori</button>
            <button class="btn btn-primary">Dodaj člana</button>
        </footer>
    </form>

    {if $.User && ($Project->hasMember($.User) || $.Session->hasAccountLevel('Staff'))}
        <form id="post-update" class="modal fade hide" action="/projects/{$Project->Handle}/updates" method="POST">
            <header class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h3>Napiši novost o projektu</h3>
            </header>
            <section class="modal-body">
                <textarea class="input-block-level" name="Body" rows="10" required></textarea>
                <span class="help-block">Markdown je podržan</span>
            </section>
            <footer class="modal-footer">
                <button class="btn" data-dismiss="modal" aria-hidden="true">Zatvori</button>
                <button class="btn btn-primary">Objavi novost</button>
            </footer>
        </form>
    {/if}

    {if $.Session->hasAccountLevel('Staff')}
        <div id="manage-members" class="modal fade hide">
            <header class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h3>Uredi članove projekta</h3>
            </header>
            <section class="modal-body">
                <ul class="thumbnails">
                {foreach item=Membership from=$Project->Memberships}
                    <li class="thumbnail">
                        {personLink $Membership->Member}
                        <span class="role {tif !$Membership->Role && $Membership->MemberID != $Project->MaintainerID ? muted}">{projectMemberTitle $Membership}</span>

                        <div class="btn-group">
                            {if $Membership->MemberID != $Project->MaintainerID}
                                <a href="/projects/{$Project->Handle}/change-maintainer?username={$Membership->Member->Username|escape:url}" class="btn btn-mini">Postavi za Maintainera</a>
                            {/if}
                            <a href="/projects/{$Project->Handle}/remove-member?username={$Membership->Member->Username|escape:url}" class="btn btn-mini btn-danger">Ukloni</a>
                        </div>
                    </li>
                {foreachelse}
                    <li class="muted">Nema registriranih</li>
                {/foreach}
                </ul>
            </section>
        </div>
    {/if}

    {jsmin epiceditor.js+pages/project.js}
{/block}
