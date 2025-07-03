{include file="sections/header.tpl"}

<div class="row">
    <div class="col-sm-12 col-md-12">
        <div class="panel panel-primary panel-hovered panel-stacked mb30">
            <div class="panel-heading">{Lang::T('Add Customer to ODP')}</div>
            <div class="panel-body">
                <form class="form-horizontal" method="post" role="form" action="{Text::url('plugin/odp/add-customer-post')}">
                    <input type="hidden" name="csrf_token" value="{$csrf_token}">
                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('ODP Code')}</label>
                        <div class="col-md-6">
                            <select class="form-control" required id="odp_id" name="odp_id">
                            {foreach $d as $ds}
                                <option value="{$ds['id']}">{$ds['odp_code']} (slot: {$ds['capacity']})</option>
                            {/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('Customer')}</label>
                        <div class="col-md-6">
                            <div class="panel-body">
                                <!-- Customers Attributes add start -->
                                <div id="custom-fields-container">
                                </div>
                                <!-- Customers Attributes add end -->
                            </div>
                            <div class="panel-footer">
                                <button class="btn btn-success btn-block" type="button"
                                    id="add-custom-field">{Lang::T('Add')}</button>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-offset-2 col-md-6">
                            <button class="btn btn-success"
                                onclick="return ask(this, '{Lang::T("Continue the add customer process?")}')"
                                type="submit">{Lang::T('Save Changes')}</button>
                            Or <a href="{Text::url('plugin/odp')}">{Lang::T('Cancel')}</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
{literal}
<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function() {
        var customFieldsContainer = document.getElementById('custom-fields-container');
        var addCustomFieldButton = document.getElementById('add-custom-field');

        addCustomFieldButton.addEventListener('click', function() {
            var fieldIndex = customFieldsContainer.children.length;
            var newField = document.createElement('div');
            newField.className = 'form-group';
            newField.innerHTML = `
            <div class="col-md-4">
                <input type="text" class="form-control" name="username_customers[]" placeholder="Username of customer">
            </div>
            <div class="col-md-6">
                <input type="text" class="form-control" name="cable_codes[]" placeholder="Cable Code">
            </div>
            <div class="col-md-2">
                <button type="button" class="remove-custom-field btn btn-danger btn-sm">-</button>
            </div>
        `;
            customFieldsContainer.appendChild(newField);
        });

        customFieldsContainer.addEventListener('click', function(event) {
            if (event.target.classList.contains('remove-custom-field')) {
                var fieldContainer = event.target.parentNode.parentNode;
                fieldContainer.parentNode.removeChild(fieldContainer);
            }
        });
    });
</script>
{/literal}

{include file="sections/footer.tpl"}