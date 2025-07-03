{include file="sections/header.tpl"}

<div class="row">
    <div class="col-sm-12 col-md-12">
        <div class="panel panel-primary panel-hovered panel-stacked mb30">
            <div class="panel-heading">{Lang::T('Add ODP')}</div>
            <div class="panel-body">
                <form class="form-horizontal" method="post" role="form" action="{Text::url('plugin/odp/add-post')}">
                    <input type="hidden" name="csrf_token" value="{$csrf_token}">
                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('Pole')}</label>
                        <div class="col-md-6">
                            <label style="margin-right:8px"><input type="radio" required checked id="pole" name="pole" value="standalone" style="margin-right:4px">{Lang::T('Standalone')}</label>
                            <label><input type="radio" required id="pole" name="pole" value="shared" style="margin-right:4px">{Lang::T('Shared')}</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('ODP Code')}</label>
                        <div class="col-md-6">
                            <input type="text" required class="form-control" id="odp_code" name="odp_code">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('Capacity')}</label>
                        <div class="col-md-6">
                            <input type="number" required class="form-control" id="capacity" name="capacity">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('Ratio')}</label>
                        <div class="col-md-6">
                            <input type="text" class="form-control" id="ratio" name="ratio">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('Coordinates')}</label>
                        <div class="col-md-6">
                            <input name="coordinates" id="coordinates" class="form-control" value=""
                                placeholder="-6.465422, 3.406448">
                            <div id="map" style="width: '100%'; height: 200px; min-height: 150px;"></div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('Description')}</label>
                        <div class="col-md-6">
                            <input type="text" class="form-control" id="descriptions" name="descriptions">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-offset-2 col-md-6">
                            <button class="btn btn-success"
                                onclick="return ask(this, '{Lang::T("Continue the ODP creation process?")}')"
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
    <script src="https://unpkg.com/leaflet@1.9.3/dist/leaflet.js"></script>
    <script>
        function getLocation() {
            if (window.location.protocol == "https:" && navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(showPosition);
            } else {
                setupMap(51.505, -0.09);
            }
        }

        function showPosition(position) {
            setupMap(position.coords.latitude, position.coords.longitude);
        }

        function setupMap(lat, lon) {
            var map = L.map('map').setView([lat, lon], 13);
            L.tileLayer('https://{s}.google.com/vt/lyrs=m&hl=en&x={x}&y={y}&z={z}&s=Ga', {
            subdomains: ['mt0', 'mt1', 'mt2', 'mt3'],
                maxZoom: 20
        }).addTo(map);
        var marker = L.marker([lat, lon]).addTo(map);
        map.on('click', function(e) {
            var coord = e.latlng;
            var lat = coord.lat;
            var lng = coord.lng;
            var newLatLng = new L.LatLng(lat, lng);
            marker.setLatLng(newLatLng);
            $('#coordinates').val(lat + ',' + lng);
        });
        }
        window.onload = function() {
            getLocation();
        }
    </script>
{/literal}


{include file="sections/footer.tpl"}