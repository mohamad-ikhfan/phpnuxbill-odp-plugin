{include file="sections/header.tpl"}
<style>
    .dataTables_wrapper .dataTables_paginate .paginate_button {
        display: inline-block;
        padding: 5px 10px;
        margin-right: 5px;
        border: 1px solid #ccc;
        background-color: #fff;
        color: #333;
        cursor: pointer;
    }
</style>

<div class="row">
    <div class="col-sm-12">
        <div class="panel panel-hovered mb20 panel-primary">
            <div class="panel-heading">
                {Lang::T('Manage ODP')}
            </div>
            <div class="panel-body">
                <div class="md-whiteframe-z1 mb20 text-center" style="padding: 15px">
                    <div align="right">
                        <a href="{Text::url('plugin/odp/add-customer')}" class="btn btn-primary text-black" style="padding: 6px 20px"
                            title="{Lang::T('Add customer')}">
                            <i class="ion ion-android-add"></i>&nbsp;Add customer
                        </a>
                        <a href="{Text::url('plugin/odp/add')}" class="btn btn-success text-black" style="padding: 6px 20px"
                            title="{Lang::T('Add')}">
                            <i class="ion ion-android-add"></i>&nbsp;<i class="glyphicon glyphicon-hdd"></i>
                        </a>
                    </div>
                </div>
                <br>&nbsp;
                <div class="table-responsive table_mobile">
                    <table id="customerTable" class="table table-bordered table-striped table-condensed">
                        <thead>
                            <tr>
                                <th>{Lang::T('ODP Code')}</th>
                                <th>{Lang::T('Core Used')}</th>
                                <th>{Lang::T('Capacity')}</th>
                                <th>{Lang::T('Pole')}</th>
                                <th>{Lang::T('Ratio')}</th>
                                <th>{Lang::T('Passive')}</th>
                                <th>{Lang::T('Input Attenuation')}</th>
                                <th>{Lang::T('Output Attenuation')}</th>
                                <th>{Lang::T('ODP Attenuation')}</th>
                                <th>{Lang::T('Coordinates')}</th>
                                <th>{Lang::T('Descriptions')}</th>
                                <th class="text-center">{Lang::T('Manage')}</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach $d as $ds}
                                <tr>
                                    <td>{$ds['odp_code']}</td>
                                    <td>{$ds['core_used']}</td>
                                    <td>{$ds['capacity']}</td>
                                    <td>{$ds['pole']}</td>
                                    <td>{$ds['ratio']}</td>
                                    <td>{$ds['passive']}</td>
                                    <td>{$ds['input_attenuation']}</td>
                                    <td>{$ds['output_attenuation']}</td>
                                    <td>{$ds['odp_attenuation']}</td>
                                    <td>
                                    {if $ds['coordinates']}
                                    <a href="https://www.google.com/maps/dir//{$ds['coordinates']}/" target="_blank"
                                        class="btn btn-default btn-xs" title="{$ds['coordinates']}"><i
                                            class="glyphicon glyphicon-map-marker"></i>&nbsp;{$ds['coordinates']}</a>
                                    {/if}
                                    </td>
                                    <td>{$ds['descriptions']}</td>
                                    <td align="center">
                                        <a href="{Text::url('plugin/odp/view/')}{$ds['id']}"
                                            class="btn btn-primary btn-xs">{Lang::T('View')}</a>
                                        <a href="{Text::url('plugin/odp/edit/')}{$ds['id']}"
                                            class="btn btn-info btn-xs">{Lang::T('Edit')}</a>
                                        <a href="{Text::url('plugin/odp/delete/')}{$ds['id']}" id="{$ds['id']}"
                                            onclick="return ask(this, '{Lang::T('Delete')}?')"
                                            class="btn btn-danger btn-xs"><i class="glyphicon glyphicon-trash"></i></a>
                                    </td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </div>
                {include file="pagination.tpl"}
            </div>
        </div>
    </div>
</div>

{include file = "sections/footer.tpl" }