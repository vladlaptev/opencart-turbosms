<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<button type="submit" form="form-smsnot" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"> Сохранить настройки</i></button>
				<a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
			</div>
			<h1><?php echo $heading_title; ?></h1>
			<ul class="breadcrumb">
			<?php foreach ($breadcrumbs as $breadcrumb) { ?>
				<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
			<?php } ?>
			</ul>
		</div>
	</div>
<div class="container-fluid">
	<?php if ($error_warning) { ?>
	<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
		<button type="button" class="close" data-dismiss="alert">&times;</button>
	</div>
	<?php } ?>

<?php
			 		if ( ($data['smsnot-login'] != '') && ($data['smsnot-password'] != '') ){ ?>
			 		<div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> Соединение со шлюзом установлено! Ваш баланс: <?php echo $balance; ?>
		<button type="button" class="close" data-dismiss="alert">&times;</button>
	</div>
			 		<?php
			 		}

			 		else { ?>
<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> Ошибка соединения со шлюзом (проверьте логин и/или пароль)
		<button type="button" class="close" data-dismiss="alert">&times;</button>
	</div>			 		
			 		<?php }
				?>

	<div class="panel panel-default">
		<div class="panel-heading">
			<div class="row">
				<div class="col-sm-6">
				<h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_description; ?></h3>
				</div>
				<div class="col-sm-6 text-right">
					<div class="btn-group" role="group" aria-label="...">
						<button type="button" id="balance" class="btn btn-default" title="<?php echo $text_refresh; ?>"><?php echo $entry_balance; ?> <?php echo $balance; ?></button>
						<a href="https://turbosms.ua/credits/add.html" target="_blank" class="btn btn-success" title="<?php echo $text_money_add; ?>">+</a>
					</div>
				</div>
			</div>
		</div>
		<div class="panel-body">
		<?php
		foreach ($customer_groups as $value) {
			$option_all='<option value="2'.$value['customer_group_id'].'">'.$text_all_group.' '.$value['name'].'</option>';
			$option_news='<option value="3'.$value['customer_group_id'].'">'.$text_newsletter_group.' '.$value['name'].'</option>';
		}
		?>
		<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-smsnot" class="form-horizontal">

		<ul class="nav nav-tabs">
			<li><a href="#tab-sending" data-toggle="tab"><?php echo $tab_sending; ?></a></li>
			<li class="active"><a href="#tab-notice" data-toggle="tab"><?php echo $tab_notice; ?></a></li>
			<li><a href="#tab-gate" data-toggle="tab"><?php echo $tab_gate; ?></a></li>
			<?php /*<li><a href="#tab-log" data-toggle="tab"><?php echo $tab_log; ?></a></li>*/?>
		</ul>
		<div class="tab-content">
			
			<div class="tab-pane" id="tab-sending">
				<div class="form-group">
					<label class="col-sm-2 control-label" for="input-message">
						<span data-toggle="tooltip" data-original-title="<?php echo $help_message; ?>"><?php echo $entry_message; ?></span>
					</label>
					<div class="col-sm-10">

						<textarea name="input-message" rows="5" placeholder="<?php echo $entry_message; ?>" id="input-message" class="form-control"></textarea>
						<div class="progress">
						  <div class="progress-bar" id="progress-barid" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 0%;"></div>
						</div>
						<div class="row">
							<div class="col-sm-6">
								<div><?php echo $entry_characters; ?> <span id="count">0</span></div>
								<div>SMS: <span id="countSMS">1</span></div>
							</div>
						</div>
					</div>
				</div>

				<div class="form-group">
					<label class="col-sm-2 control-label" for="input-phone2">
						<span data-toggle="tooltip" data-original-title="Телефон">Введите телефон</span>
					</label>
					<div class="col-sm-10">

						<input name="input-phone2" rows="1" placeholder="Введите телефон" id="input-phone2" class="form-control"></input>
					</div>
				</div>


				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<button class="btn btn-default" type="button" id="send"><?php echo $button_send; ?></button>
					</div>
				</div>
				<div id="multi-result"></div>
			</div>

			<div class="tab-pane fade active in" id="tab-notice">
				<div class="form-group">
					<label class="col-sm-2 control-label" for="input-enabled"><?php echo $entry_enabled; ?></label>
					<div class="col-sm-10">
						<select name="smsnot-enabled" class="form-control">
							<?php if ($data['smsnot-enabled']) { ?>
							<option value="1" selected="selected"><?php echo $text_enable; ?></option>
							<option value="0"><?php echo $text_disable; ?></option>
							<?php } else { ?>
							<option value="1"><?php echo $text_enable; ?></option>
							<option value="0" selected="selected"><?php echo $text_disable; ?></option>
							<?php } ?>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label" for="input-message-template">
						<span data-toggle="tooltip" data-original-title="<?php echo $help_message_template; ?>"><?php echo $entry_message_template; ?></span>
					</label>
					<div class="col-sm-10">
						<div class="btn-group-xs btn-group" role="group">
							<button class="btn btn-default btni" type="button" data-insert="{OrderID}" data-target="input-message-template"><?php echo $button_orderid; ?></button>
							<button class="btn btn-default btni" type="button" data-insert="{Status}" data-target="input-message-template"><?php echo $button_status; ?></button>
							<button class="btn btn-default btni" type="button" data-insert="{StoreName}" data-target="input-message-template"><?php echo $button_storename; ?></button>
						</div>
						<textarea name="smsnot-message-template" rows="5" placeholder="<?php echo $entry_message_template; ?>" id="input-message-template" class="form-control"><?php echo $data['smsnot-message-template']; ?></textarea>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label" for="input-message-customer">
						<span data-toggle="tooltip" data-original-title="<?php echo $help_message_customer; ?>"><?php echo $entry_message_customer; ?></span>
					</label>
					<div class="col-sm-10">
						<div class="btn-group-xs btn-group" role="group">
							<button class="btn btn-default btni" type="button" data-insert="{OrderID}" data-target="input-message-customer"><?php echo $button_orderid; ?></button>
							<button class="btn btn-default btni" type="button" data-insert="{StoreName}" data-target="input-message-customer"><?php echo $button_storename; ?></button>
						</div>
						<textarea name="smsnot-message-customer" rows="5" placeholder="<?php echo $entry_message_customer; ?>" id="input-message-customer" class="form-control"><?php echo $data['smsnot-message-customer']; ?></textarea>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label" for="input-message-admin">
						<span data-toggle="tooltip" data-original-title="<?php echo $help_message_admin; ?>"><?php echo $entry_message_admin; ?></span>
					</label>
					<div class="col-sm-10">
						<div class="btn-group-xs btn-group" role="group">
							<button class="btn btn-default btni" type="button" data-insert="{OrderID}" data-target="input-message-admin"><?php echo $button_orderid; ?></button>
							<button class="btn btn-default btni" type="button" data-insert="{StoreName}" data-target="input-message-admin"><?php echo $button_storename; ?></button>
							<button class="btn btn-default btni" type="button" data-insert="{Total}" data-target="input-message-admin"><?php echo $button_total; ?></button>
						</div>
						<textarea name="smsnot-message-admin" rows="5" placeholder="<?php echo $entry_message_admin; ?>" id="input-message-admin" class="form-control"><?php echo $data['smsnot-message-admin']; ?></textarea>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label"><?php echo $entry_to; ?></label>
					<div class="col-sm-10">
						<div class="well well-sm" style="height: 150px; overflow: auto;">
							<div class="checkbox">
								<label>
								<?php if ((isset($data['smsnot-new-order'])) AND ($data['smsnot-new-order'])) { ?>
								<input type="checkbox" name="smsnot-new-order" checked="checked" />
								<?php } else { ?>
								<input type="checkbox" name="smsnot-new-order" />
								<?php } ?>
								<?php echo $text_new_order; ?>
								</label>
							</div>
							<div class="checkbox">
								<label>
								<?php if ((isset($data['smsnot-order-change'])) AND ($data['smsnot-order-change'])) { ?>
								<input type="checkbox" name="smsnot-order-change" checked="checked" />
								<?php } else { ?>
								<input type="checkbox" name="smsnot-order-change" />
								<?php } ?>
								<?php echo $text_order_change; ?>
								</label>
							</div>
							<div class="checkbox">
								<label>
								<?php if ((isset($data['smsnot-owner'])) AND ($data['smsnot-owner'])) { ?>
								<input type="checkbox" name="smsnot-owner" checked="checked" />
								<?php } else { ?>
								<input type="checkbox" name="smsnot-owner" />
								<?php } ?>
								<?php echo $text_owner; ?>
								</label>
							</div>
						</div>
					</div>
				</div>
			</div>
			

			<div class="tab-pane" id="tab-gate">
				<div class="form-group">
					<label class="col-sm-3 control-label" for="input-login"><?php echo $entry_login; ?></label>
					<div class="col-sm-9">
					  <input name="smsnot-login" type="text" placeholder="<?php echo $entry_login; ?>" id="input-login" class="form-control" value="<?php echo $data['smsnot-login']; ?>">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label" for="input-password"><?php echo $entry_password; ?></label>
					<div class="col-sm-9">
						<input name="smsnot-password" type="text" placeholder="<?php echo $entry_password; ?>" id="input-password" class="form-control" value="<?php echo $data['smsnot-password']; ?>" maxlength="11">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label" for="input-phone"><?php echo $entry_phone; ?></label>
					<div class="col-sm-9">
						<input name="smsnot-phone" type="text" placeholder="<?php echo $entry_phone; ?>" id="input-phone" class="form-control digitOnly" value="<?php echo $data['smsnot-phone']; ?>" maxlength="13">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label" for="input-sender">Номер администратора в turbosms.ua или имя (альфанумерическое)</label>
					<div class="col-sm-9">
						<input name="smsnot-sender" type="text" placeholder="Номер администратора в turbosms.ua или имя (альфанумерическое)" id="input-sender" class="form-control" value="<?php echo $data['smsnot-sender']; ?>" maxlength="13">
</br>
					<div class="alert alert-info">Внимание: Если в аккаунте turbosms.ua добавлено альфанумерическое имя (не важно какое, пусть даже не зарегистрированное оператором и ваши сообщения отправляются через mobinfo), то необходимо его указать вместо мобильного номера, так как сообщения не будут отправляться.</div>
					</div>
				</div>
		
				
				<div id="result"></div>
			</div>

			<?php /*<div class="tab-pane active in" id="tab-log">
				<div class="pull-right">
					<a href="<?php echo $download ?>" data-toggle="tooltip" title="" class="btn btn-primary" data-original-title="<?php echo $button_download ?>"><i class="fa fa-download"></i></a>
					<a onclick="confirm('<?php echo $help_sure; ?>') ? location.href='<?php echo $clear; ?>' : false;" data-toggle="tooltip" title="" class="btn btn-danger" data-original-title="<?php echo $button_clear; ?>"><i class="fa fa-eraser"></i></a><p>&nbsp;</p>
				</div>
				<textarea wrap="off" rows="15" readonly="" class="form-control"><?php echo $log; ?></textarea>
			</div> */?>
			
			
		</div>
		</form>
		</div>
	</div>
</div>
<script type="text/javascript">
$( document ).ready(function() {
	$("#input-message").keyup(function() {
		if (/[а-я]/i.test($("#input-message").val()))
			max=70;
		else
			max=140;
		smsc=Math.ceil($("#input-message").val().length/max);
		sm=max*(smsc-1);
		var box=$(this).val();
		var main = (box.length-sm) *100;
		var value= (main / max);
		$('#count').html(box.length);
		$('#progress-barid').animate(
		{
			"width": value+'%',
		}, 1);
		$('#countSMS').html(smsc);
		return false;
	});

	$(".digitOnly").keyup(function (){
		$(this).val($(this).val().replace(/[^\d+]/g, ''));
	});

	$("#send").click(function(){
		var data="&message="+$('#input-message').val()+"&to="+$('#input-phone2').val();
		var btn = $(this);
		btn.button('Отправка сообщения');
		$.ajax({
			type: "POST",
			url: "index.php?route=module/smsnot/send&token=<?php echo $tokenonly; ?>",
			cache: false,
			data: data,
			success: function(html){
				var jsonData = JSON.parse(html);
				console.log(jsonData.SendSMSResult.ResultArray);
				if (jsonData.SendSMSResult.ResultArray[0] != "Сообщения успешно отправлены")
					$('#multi-result').html('<div class="alert alert-danger">'+jsonData.SendSMSResult.ResultArray+'</div>');
				else
				{
					$('#multi-result').html('<div class="alert alert-success">'+jsonData.SendSMSResult.ResultArray[0]+'</div>');
					$('#balance').html('<?php echo $entry_balance; ?> <?php echo $balance; ?>');
					btn.button('reset');
				}
			}
		});
	});
	jQuery.fn.extend({
		insertAtCaret: function(myValue){
		return this.each(function(i) {
			if (document.selection) {
				this.focus();
				var sel = document.selection.createRange();
				sel.text = myValue;
				this.focus();
			}
			else if (this.selectionStart || this.selectionStart == '0') {
				var startPos = this.selectionStart;
				var endPos = this.selectionEnd;
				var scrollTop = this.scrollTop;
				this.value = this.value.substring(0, startPos)+myValue+this.value.substring(endPos,this.value.length);
				this.focus();
				this.selectionStart = startPos + myValue.length;
				this.selectionEnd = startPos + myValue.length;
				this.scrollTop = scrollTop;
			} else {
				this.value += myValue;
				this.focus();
			}
		});
		}
	});
	$('.btni').click(function(){
		var target=$(this).data('target');
		var text=$(this).data('insert');
		$('#'+target).insertAtCaret(text);
	});
});
</script>
</div>
<?php echo $footer; ?>