{extends "designs/site.tpl"}

{block "title"}Registracija &mdash; {$dwoo.parent}{/block}

{block "content"}
    {$User = $data}
    <form method="POST" id="register">
    {strip}

        <div class="form-horizontal span6 offset3">
            <h2>Postani član {Laddr::$siteName|escape}!</h2>

            {if $User->validationErrors}
                <h3>Našli smo probleme u obrascu:</h3>
                <ul class="well errors">
                {foreach item=error key=field from=$User->validationErrors}
                    <li>{$field}: {$error|escape}</li>
                {/foreach}
                </ul>
            {/if}

            <div class="control-group">
                <label class="control-label">
                    Ime
                </label>
                <div class="controls">
                    <input type="text" name="FirstName" value="{refill field=FirstName}" placeholder="Ivan">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">
                    Prezime
                </label>
                <div class="controls">
                    <input type="text" name="LastName" value="{refill field=LastName}" placeholder="Lončar">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">
                    Email adresa
                </label>
                <div class="controls">
                    <input type="email" name="Email" value="{refill field=Email}" placeholder="civic.hacker@primjer.com">
                    <div class="muted" id="register-privacy">
                        Tvoja email adresa <strong>biti</strong> će vidljiva drugim prijavljenim članovima.
                    </div>
                </div>

            </div>
            <div class="control-group">
                <label class="control-label">
                    Korisničko ime
                </label>
                <div class="controls">
                    <input type="text" name="Username" value="{refill field=Username}" placeholder="Nadimak">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">
                    Lozinka
                </label>
                <div class="controls">
                    <input type="password" name="Password">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">
                    Ponovi lozinku
                </label>
                <div class="controls">
                    <input type="password" name="PasswordConfirm">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label"></label>
                <div class="controls">
                    <input type="submit" class="btn btn-primary submit" value="Pošalji"><br/><br/>
                    <p class="form-hint">Već si registriran član? <a href="/login">Prijavi se</a></p>
                </div>
            </div>
        </div>
    {/strip}
    </form>

{/block}
