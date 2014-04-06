{extends designs/site.tpl}

{block title}{if $data->isPhantom}Kreiraj{else}Uredi {$data->Title|escape}{/if} projekt &mdash; {$dwoo.parent}{/block}

{block js-bottom}
    {$dwoo.parent}
    <script>
        var tagTitles = {Tag::getAllTitles()|json_encode};
    </script>
    {jsmin "epiceditor.js+pages/project-edit.js"}
{/block}

{block content}
    {$Project = $data}

    <h2>
        {if $Project->isPhantom}
            Kreiraj novi projekt
        {else}
            Uredi projekt <strong>{$Project->Title|escape}
        {/if}
    </h2>

    {if !$Project->isValid}
    <div class="error well">
        <strong>Našao sam probleme s tvojim obrascem:</strong>
        <ul class="errors">
        {foreach item=error key=field from=$Project->validationErrors}
            <li>{$error}</li>
        {/foreach}
        </ul>
    </div>
    {/if}


    <form method="POST" class="form-horizontal">
        <div class="control-group">
            <label for="field-title" class="control-label">Naslov:</label>
            <div class="controls">
                <input name="Title" id="field-title" placeholder="Vizualizacija incidenata u Zagrebu"
                    value="{refill field=Title default=$Project->Title}" />
            </div>
        </div>
        <div class="control-group">
            <label for="field-url-users" class="control-label">Link za korisnike:</label>
            <div class="controls">
                <input name="UsersUrl" id="field-url-users" placeholder="http://mypublicapp.org"
                 value="{refill field=UsersUrl default=$Project->UsersUrl}"/>
            </div>
        </div>
        <div class="control-group">
            <label for="field-url-developers" class="control-label">Link za developere:</label>
            <div class="controls">
                <input name="DevelopersUrl" id="field-url-developers" placeholder="http://github.com/..." value="{refill field=DevelopersUrl default=$Project->DevelopersUrl}"/>
            </div>
        </div>
        <div class="control-group">
            <label for="tagsInput" class="control-label">Oznake:</label>
            <div class="controls">
                <input id="tagsInput" name="tags" placeholder="tech.Ruby, topic.Prijevoz" value="{refill field=tags default=Tag::getTagsString($Project->Tags)}"/>
            </div>
        </div>
        <div class="control-group">
            <label for="README" class="control-label">README(.md)</label>
            <div class="controls">
                <textarea name="README" class="input-block-level" rows="10">{refill field=README default=$Project->README}</textarea>
                <br/><br/>
                <input type="submit" class="btn-small btn" value="{tif $Project->isPhantom ? 'Kreiraj projekt' : 'Spremi promjene'}"/>
            </div>
        </div>
        </div>
    </form>
{/block}
