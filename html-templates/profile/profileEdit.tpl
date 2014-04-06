{extends "designs/site.tpl"}

{block "title"}Uredi profil &mdash; {$dwoo.parent}{/block}

{block js-bottom}
    {$dwoo.parent}
    <script>
        var tagTitles = {Tag::getAllTitles()|json_encode};
    </script>
    {jsmin "epiceditor.js+pages/profile-edit.js"}
{/block}

{block "content"}
    <h1>Uredi svoj profil</h1>
    <hr class="clear" />

    {if $.get.status == 'photoUploaded'}
        <p class="status highlight">Fotografija je uplodana.</p>
    {elseif $.get.status == 'photoPrimaried'}
        <p class="status highlight">Zadana fotografija je postavljena.</p>
    {elseif $.get.status == 'photoDeleted'}
        <p class="status highlight">Fotografija obrisana.</p>
    {elseif $.get.status == 'passwordChanged'}
        <p class="status highlight">Lozinka promijenjena.</p>
    {elseif $.get.status == 'saved'}
        <p class="status highlight">Profil spremljen.</p>
    {/if}


    <form id="uploadPhotoForm" class="generic" action="/profile/uploadPhoto" method="POST" enctype="multipart/form-data">

        <fieldset class="section">
            <legend>Slike</legend>
            {strip}
            <div class="photosGallery clearfix">
                {foreach item=Photo from=$.User->Photos}
                    <div class="photo {if $Photo->ID == $.User->PrimaryPhotoID}highlight{/if}">
                        <div class="photothumb"><img src="{$Photo->getThumbnailRequest(100,100)}"></div>
                        {*<input type="text" name="Caption[{$Photo->ID}]" class="caption" value="{$Photo->Caption|escape}">*}
                        <div class="buttons">
                            <span>{if $Photo->ID != $.Session->Person->PrimaryPhotoID}
                                <a href="/profile/primaryPhoto?MediaID={$Photo->ID}" alt="Make Default" title="Make Default"><img src="/img/icons/fugue/user-silhouette.png" alt="Make Default" /></a>
                            {else}
                                <img src="/img/icons/fugue/user-silhouette.png" alt="Default Photo" class="nofade" />Default
                            {/if}</span>
                            <a href="/profile/deletePhoto?MediaID={$Photo->ID}" alt="Delete Photo" title="Delete Photo" onclick="return confirm('Jesi li siguran da želiš obrisati ovu fotografiju iz svog profila?');"><img src="/img/icons/fugue/slash.png" alt="Delete Photo" /></a>
                        </div>
                    </div>
                {/foreach}
            </div>
            {/strip}

            <div class="field upload">
                <input type="file" name="photoFile" id="photoFile">
            </div>
            <div class="submit">
                <input type="submit" class="submit inline" value="Uplodaj novu forografiju">
            </div>
        </fieldset>
    </form>

    <form method="POST" id="profileForm" class="generic">
    <h2 class="legend">Detalji profila</h2>
    <fieldset class="section">
        <legend>Profile details</legend>
        <div class="field">
            <label for="Location">Mjesto</label>
            <input type="text" class="text" id="Location" name="Location" value="{refill field=Location default=$.User->Location}">
        </div>

        <div class="field expand">
            <label for="about">O meni</label>
            <textarea id="about" name="About">{refill field=About default=$.User->About}</textarea>
            <p class="hint">Koristi <a href="http://daringfireball.net/projects/markdown">Markdown</a> za oblikovanje teksta</p>
        </div>

        <div class="field expand">
            <label for="tagsInput">Osobne oznake</label>
            <input type="text" id="tagsInput" name="tags" placeholder="tech.Ruby, topic.Prijevoz" value="{refill field=tags default=Tag::getTagsString($.User->Tags)}">
        </div>

        <div class="submit">
            <input type="submit" class="submit" value="Spremi profil">
        </div>

    </fieldset>


    <h2 class="legend">Kontakt informacije</h2>
    <fieldset class="section">
        <legend>Kontakt informacije</legend>
        <div class="field">
            <label for="Email">Email</label>
            <input type="email" class="text" id="Email" name="Email" value="{refill field=Email default=$.User->Email}">
        </div>

        <div class="field">
            <label for="Phone">Telefon</label>
            <input type="tel" class="text" id="Phone" name="Phone" value="{refill field=Phone default=$.User->Phone modifier=phone}">
        </div>

        <div class="field">
            <label for="Twitter">Twitter</label>
            <input type="text" class="text" id="Twitter" name="Twitter" value="{refill field=Twitter default=$.User->Twitter}">
        </div>

        <div class="submit">
            <input type="submit" class="submit" value="Spremi profil">
        </div>

    </fieldset>
    </form>



    <form action="/profile/password" method="POST" id="passwordForm" class="generic">
    <h2 class="legend">Promijeni lozinku</h2>
    <fieldset class="section">
        <legend>Promijeni lozinku</legend>
        <div class="field">
            <label for="oldpassword">Stara lozinka</label>
            <input type="password" class="text" id="oldpassword" name="OldPassword">
        </div>
        <div class="field">
            <label for="password">Nova lozinka</label>
            <input type="password" class="text" id="password" name="Password">
            <input type="password" class="text" id="password2" name="PasswordConfirm">
            <p class="hint">Napiši svoju novu lozinku u oba polja kako bi bio siguran da si točno upisao.</p>
        </div>

        <div class="submit">
            <input type="submit" class="submit" value="Spremi novu lozinku">
        </div>

    </fieldset>
    </form>

{/block}
