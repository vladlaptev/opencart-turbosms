<?php
class ControllerModuleSmsnot extends Controller {

	public function onCheckout($order_id) {
		$this->load->model('checkout/order');
		$order_info = $this->model_checkout_order->getOrder($order_id);
		$this->load->model('setting/setting');
		$setting = $this->model_setting_setting->getSetting('smsnot');

		if(isset($setting) && ($setting['smsnot-enabled'])) {
			if (!$order_info['order_status_id']) {
				if ($setting['smsnot-owner'] == 'on') {
					$original = array("{StoreName}","{OrderID}", "{Total}");
					$replace = array($this->config->get('config_name'), $order_id, $order_info['total']);

					$message = str_replace($original, $replace, $setting['smsnot-message-admin']);
					$this->sms_send($setting['smsnot-phone'], $message);
				}
				//Отправка СМС админу
				if ($setting['smsnot-new-order'] == 'on') {
					$original = array("{StoreName}","{OrderID}");
					$replace = array($this->config->get('config_name'), $order_id);

					$message = str_replace($original, $replace, $setting['smsnot-message-customer']);
					if (preg_match('/(\+|)[0-9]*/', $order_info['telephone'])) {
						$this->sms_send($order_info['telephone'], $message);
					}
				}
				//Отправка СМС новому пользователю
			}
		}
    }

	public function onHistoryChange($order_id) {
		$this->load->model('checkout/order');
		$order_info = $this->model_checkout_order->getOrder($order_id);	
		$this->load->model('setting/setting');
		$this->load->model('module/smsnot');

		$setting = $this->model_setting_setting->getSetting('smsnot');

		if(isset($setting) && ($setting['smsnot-enabled']) && ($setting['smsnot-order-change'] == 'on')) {
			if ($order_info['order_status_id'] && $this->model_module_smsnot->getHistoryCount($order_id)>1) {
				$status = (isset($order_info['order_status']))?$order_info['order_status']:"";

				$original = array("{StoreName}","{OrderID}","{Status}");
				$replace = array($this->config->get('config_name'), $order_id, $status);

				$message = str_replace($original, $replace, $setting['smsnot-message-template']);
				
				if (preg_match('/(\+|)[0-9]*/', $order_info['telephone'])) {
					$response=$this->sms_send($order_info['telephone'], $message);
				}
			}
		}
	}

    private function sms_send($to=0, $text=0) {

    	$this->load->model('setting/setting');
		$this->load->model('module/smsnot');
		$setting = $this->model_setting_setting->getSetting('smsnot');

		if ( isset($setting) && ($setting['smsnot-login']) && ($setting['smsnot-password']) && ($setting['smsnot-sender']))
		{
		header ('Content-type: text/html; charset=utf-8'); 

		$client = new SoapClient ('http://turbosms.in.ua/api/wsdl.html'); 

		$auth = Array ( 
		'login' => $setting['smsnot-login'], 
		'password' => $setting['smsnot-password'] 
		); 

		$result = $client->Auth ($auth); 
		$textsend = $text; 
		$sms = Array ( 
		'sender' => $setting['smsnot-sender'], 
		'destination' => $to, 
		'text' => $textsend
		);

		$result = $client->SendSMS ($sms); 
	}
		
	}

}