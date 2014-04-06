{extends "designs/site.tpl"}

{block "title"}Prijava &mdash; {$dwoo.parent}{/block}


{block "content"}
    <center><h2>Prijava u {Laddr::$siteName|escape}</h2></center>
    <br/>
    <div class="container">
    <div class="span9 offset3">
    <form method="POST" id="login" class="form-horizontal">

    {foreach item=value key=name from=$postVars}
        {if is_array($value)}
            {foreach item=subvalue key=subkey from=$value}
                <input type="hidden" name="{$name|escape}[{$subkey|escape}]" value="{$subvalue|escape}">
            {/foreach}
        {else}
            <input type="hidden" name="{$name|escape}" value="{$value|escape}">
        {/if}
    {/foreach}

    <input type="hidden" name="_LOGIN[returnMethod]" value="{refill field=_LOGIN.returnMethod default=$.server.REQUEST_METHOD}">
    <input type="hidden" name="_LOGIN[return]" value="{refill field=_LOGIN.return default=$.server.REQUEST_URI}">

    {if $authException}
        <p class="error">
            Prijava neuspjela: {$authException->getMessage()}
        </p>
    {elseif $error}
        <p class="error">
            Prijava neuspjela: {$error}
        </p>
    {/if}

    {strip}
        <div class="control-group">
            <label for="_LOGIN[username]" class="control-label">Korisničko ime</label>
            <div class="controls">
                <input type="text" placeholder="Korisničko ime ili email" name="_LOGIN[username]" value="{refill field=_LOGIN.username}"
                    autocorrect="off" autocapitalize="off">
            </div>
        </div>

        <div class="control-group">
            <label for="_LOGIN[password]" class="control-label">Lozinka</label>
            <div class="controls">
                <input type="password" name="_LOGIN[password]" placeholder="Password"/>
                <br/>
                <br/>
                <label class="checkbox" for="_LOGIN[remember]">
                    <input type="checkbox" name="_LOGIN[remember]"/> Zapamti me
                </label>
                <br/>
                <input type="submit" class="btn btn-small" value="Prijava"/>
                <br/>
                <br/>
                <p>Možeš <a href="/register/recover">zatražiti svoju lozinku</a>,<br/>ili se <a href="/register">učlaniti</a> u ekspertnu skupinu.</p>
            </div>
        </div>
    {/strip}
    </form>
    </div>

    </div>

{/block}
