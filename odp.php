<?php

register_menu(" ODP", true, "odp", 'AFTER_DASHBOARD', 'glyphicon glyphicon-hdd', "New", "green");

function odp()
{
    global $ui, $routes;
    _admin();

    $action = $routes['2'];

    $admin = Admin::_info();
    $ui->assign('_admin', $admin);

    $leafletpickerHeader = <<<EOT
        <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.3/dist/leaflet.css">
        EOT;

    switch ($action) {
        case 'add':
            $ui->assign('_title', "Add ODP");

            $ui->assign('xheader', $leafletpickerHeader);

            $ui->display('odp/add.tpl');
            break;
        case 'add-post':
            $csrf_token = _post('csrf_token');
            if (!Csrf::check($csrf_token)) {
                r2(getUrl('plugin/odp/add'), 'e', Lang::T('Invalid or Expired CSRF Token') . ".");
            }

            $odp_code = _post('odp_code');
            $core_used = _post('core_used');
            $capacity = _post('capacity');
            $pole = _post('pole');
            $passive = _post('passive');
            $ratio = _post('ratio');
            $input_attenuation = _post('input_attenuation');
            $output_attenuation = _post('output_attenuation');
            $odp_attenuation = _post('odp_attenuation');
            $coordinates = _post('coordinates');
            $descriptions = _post('descriptions');

            $msg = '';
            if (Validator::Length($pole, 55, 2) == false) {
                $msg .= 'Pole is required' . '<br>';
            }

            if (Validator::Length($odp_code, 55, 2) == false) {
                $msg .= 'ODP Code should be between 3 to 54 characters' . '<br>';
            }

            $d = ORM::for_table('tbl_odp')->where('odp_code', $odp_code)->find_one();
            if ($d) {
                $msg .= Lang::T('ODP Code already axist') . '<br>';
            }

            if ($msg == '') {
                $d = ORM::for_table('tbl_odp')->create();
                $d->odp_code = $odp_code;
                $d->core_used = $core_used;
                $d->capacity = $capacity;
                $d->pole = $pole;
                $d->passive = $passive;
                $d->ratio = $ratio;
                $d->input_attenuation = $input_attenuation;
                $d->output_attenuation = $output_attenuation;
                $d->odp_attenuation = $odp_attenuation;
                $d->coordinates = $coordinates;
                $d->descriptions = $descriptions;
                $d->save();

                r2(getUrl('plugin/odp'), 's', Lang::T('ODP Created Successfully'));
            } else {
                r2(getUrl('plugin/odp/add'), 'e', $msg);
            }
            break;
        case 'edit':
            $id = $routes['3'];
            $d = ORM::for_table('tbl_odp')->find_one($id);

            if (!$d) {
                r2(getUrl('plugin/odp'), 'e', Lang::T('ODP not axist') . '<br>');
            }

            if ($d) {
                $ui->assign('d', $d);
                $ui->assign('xheader', $leafletpickerHeader);
                $ui->assign('csrf_token',  Csrf::generateAndStoreToken());
                $ui->assign('_title', "Edit ODP");
                $ui->display('odp/edit.tpl');
            } else {
                r2(getUrl('plugin/odp'), 'e', Lang::T('ODP Not Found'));
            }
            break;
        case 'edit-post':
            $csrf_token = _post('csrf_token');
            if (!Csrf::check($csrf_token)) {
                r2(getUrl('plugin/odp/add'), 'e', Lang::T('Invalid or Expired CSRF Token') . ".");
            }

            $id = _post('id');
            $odp_code = _post('odp_code');
            $core_used = _post('core_used');
            $capacity = _post('capacity');
            $pole = _post('pole');
            $passive = _post('passive');
            $ratio = _post('ratio');
            $input_attenuation = _post('input_attenuation');
            $output_attenuation = _post('output_attenuation');
            $odp_attenuation = _post('odp_attenuation');
            $coordinates = _post('coordinates');
            $descriptions = _post('descriptions');

            $msg = '';
            if (Validator::Length($pole, 55, 2) == false) {
                $msg .= 'Pole is required' . '<br>';
            }

            if (Validator::Length($odp_code, 55, 2) == false) {
                $msg .= 'ODP Code should be between 3 to 54 characters' . '<br>';
            }

            $d = ORM::for_table('tbl_odp')->where('id', $id)->find_one();

            if ($msg == '') {
                $d->odp_code = $odp_code;
                $d->core_used = $core_used;
                $d->capacity = $capacity;
                $d->pole = $pole;
                $d->passive = $passive;
                $d->ratio = $ratio;
                $d->input_attenuation = $input_attenuation;
                $d->output_attenuation = $output_attenuation;
                $d->odp_attenuation = $odp_attenuation;
                $d->coordinates = $coordinates;
                $d->descriptions = $descriptions;
                $d->save();

                r2(getUrl('plugin/odp'), 's', Lang::T('ODP Updated Successfully'));
            } else {
                r2(getUrl('plugin/odp/edit/' . $id), 'e', $msg);
            }
            break;
        case 'view':
            $id = $routes['3'];
            $d = ORM::for_table('tbl_odp')->find_one($id);
            $c = ORM::for_table('tbl_register_odp_for_customer')
                ->table_alias('r')
                ->select_many(
                    'r.*',
                    'o.odp_code',
                    'c.username',
                    'c.fullname',
                    'c.phonenumber'
                )
                ->join('tbl_odp', array('r.odp_id', '=', 'o.id'), 'o')
                ->join('tbl_customers', array('r.customer_id', '=', 'c.id'), 'c')
                ->where('r.odp_id', $id)
                ->order_by_asc('r.created_at')
                ->find_many();

            if (!$d) {
                r2(getUrl('plugin/odp'), 'e', Lang::T('ODP not axist') . '<br>');
            }

            if ($d) {
                $ui->assign('d', $d);
                $ui->assign('c', $c);
                $ui->assign('xheader', $leafletpickerHeader);
                $ui->assign('_title', "View ODP");
                $ui->display('odp/view.tpl');
            } else {
                r2(getUrl('plugin/odp'), 'e', Lang::T('ODP Not Found'));
            }
            break;
        case 'delete':
            $id = $routes['3'];

            $d = ORM::for_table('tbl_odp')->find_one($id);
            if ($d) {
                $d->delete();

                r2(getUrl('plugin/odp'), 's', Lang::T('ODP Deleted Successfully'));
            } else {
                r2(getUrl('plugin/odp'), 'e', Lang::T('ODP Not Found'));
            }
            break;

        case 'add-customer':
            $ui->assign('_title', "Add Customer");

            $ui->assign('xheader', $leafletpickerHeader);
            $d = ORM::for_table('tbl_odp')->find_many();
            $ui->assign('d', $d);
            $c = ORM::for_table('tbl_customers')->find_many();
            $ui->assign('c', $c);
            $ui->display('odp/add_customer.tpl');
            break;
        case 'add-customer-post':
            $odp_id = _post('odp_id');
            $username_customers = (array) $_POST['username_customers'];
            $cables_codes = (array) $_POST['cables_codes'];

            for ($i = 0; $i < count($username_customers); $i++) {
                $customer = ORM::for_table('tbl_customers')->where('username', $username_customers[$i])->find_one();
                $register = ORM::for_table('tbl_register_odp_for_customer')->create();
                $register->odp_id = $odp_id;
                $register->customer_id = $customer->id;
                $register->cable_code = $cables_codes[$i] ?? null;
                $register->save();
            }

            r2(getUrl('plugin/odp/view/' . $odp_id), 's', Lang::T('registered ODP Successfully'));
            break;
        default:
            ORM::raw_execute("
                CREATE TABLE IF NOT EXISTS tbl_odp (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    odp_code VARCHAR(50) NOT NULL,
                    core_used VARCHAR(50) NULL,
                    capacity INT(11) NULL,
                    pole ENUM('jtn','shared') DEFAULT 'jtn',
                    ratio VARCHAR(5) NULL,
                    passive INT(11) NULL,
                    input_attenuation VARCHAR(50) NULL,
                    output_attenuation VARCHAR(50) NULL,
                    odp_attenuation VARCHAR(50) NULL,
                    coordinates VARCHAR(50) NULL,
                    descriptions VARCHAR(255) NULL,
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                )
            ");

            ORM::raw_execute("
                CREATE TABLE IF NOT EXISTS tbl_register_odp_for_customer (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    odp_id INT(11) NOT NULL,
                    customer_id INT(11) NOT NULL,
                    cable_code VARCHAR(50) NULL,
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    CONSTRAINT fk_odp FOREIGN KEY (odp_id) 
                        REFERENCES tbl_odp(id),
                    CONSTRAINT fk_customer FOREIGN KEY (customer_id) 
                        REFERENCES tbl_customers(id)
                ) ENGINE=InnoDB;
            ");

            $ui->assign('_title', "ODP");

            $search = _req('search');
            $order = _req('order', 'username');
            $filter = _req('filter', 'Active');
            $orderby = _req('orderby', 'asc');
            $order_pos = [
                'odp_code' => 0,
                'created_at' => 8,
                'balance' => 3,
                'status' => 7
            ];

            $append_url = "&order=" . urlencode($order) . "&filter=" . urlencode($filter) . "&orderby=" . urlencode($orderby);
            $query = ORM::for_table('tbl_odp');
            $d = Paginator::findMany($query, ['search' => $search], 30, $append_url);
            $ui->assign('d', $d);

            $ui->assign('xheader', '
                <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.3/css/jquery.dataTables.min.css">
                <style>
                    
                </style>');
            $ui->display('odp/list.tpl');
            break;
    }
}
