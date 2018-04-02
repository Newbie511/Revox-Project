<?php
/*
 * Made by ham999dy
 * © 2018 Revolution Team
 */
if(!defined("Vewi_TPL_File")){
	die("File not Found!");
}
if (!isset($_GET['iditem'])) {
if(!isset($_GET['type']) or $_GET['type'] == null)
    header('location: ' . URL . '?id=' . security::clean($_GET['id']) . '&go=supplies&type=general_supplies');
    ?>
    <aside id="left">
        <article>
            <ul id="left_menu">
                <li><a href="<?= URL ?>?go=supplies&type=general_supplies"><img src="img/bullet.png">General Supplies</a><p></p></li>
                <li><a href="<?= URL ?>?go=supplies&type=general_summon"><img src="img/bullet.png">Summon Supplies</a><p></p></li>
            </ul>
        </article>                   
    </aside>
    <div id="bodyOrignal">
        <div class="row">
            <?php
            switch($_GET['type']){
                case "general_supplies":
					$data = $Database->SelectW('store', array("type" => "item_supplie", "enable" => 1) );
                    break;
                    
                case "general_summon":
					$data = $Database->SelectW('store', array("type" => "item_summon", "enable" => 1) );
                    break;
                    
                default :
                    header('location: ' . URL . '?go=supplies&type=general_supplies');
            }
			while ($row = array_shift($data)) {
				?> 
				<div class="col-lg-4">
					<img src="<?= URL ?>img/icon/<?= $row['img'] ?>.jpg" alt=""/>
					<h2><?= settingWord::delete_between('<','>',settingWord::delete_between('#','#',$row['name'])) ?></h2>
					<p>Price : <?= $row['price'] ?> point</p>
					<p><a class="btn btn-default" href="<?= URL ?>?go=supplies&iditem=<?= md5($row['id'] . date('Y-m-d')) ?>" role="button">View details »</a></p>
				</div>
			<?php } ?>
        </div>
    </div>
<?php } else { ?>
    <div id="bodyOrignal" style="margin: 50px auto;width: 440px;min-height: 370px;">
        <div class="row">
            <?php
			$data = $Database->SelectWhere("store,item_store", " id = id_store AND enable = 1 GROUP BY  id");
            $idItem = security::clean($_GET['iditem']);
            for ($i = 0; $i < count($data); $i++) {
                if (md5($data[$i]['id'] . date('Y-m-d')) == $idItem) {
					if($data[$i]['desc'] !== 0 AND $data[$i]['desc'] != NULL AND $data[$i]['desc'] != "")
						$desc = $data[$i]['desc'];
					else
						$desc = settingWord::delete_between('<','>',settingWord::delete_between('#','#',Arcadia::StringResource(Arcadia::ItemResource($data[$i]['code'])[0]['tooltip_id'])[0]['value']));
                    ?>
                    <form method="POST" action="<?= URL ?>?go=buy">
                        <input type="hidden" name="iditem" value="<?= $idItem ?>">
                        <div id="getItem">
							<img src="<?= URL ?>img/icon/<?= $data[$i]['img'] ?>.jpg" alt=""/>
                            <h2><?= $data[$i]['name'] ?></h2>
                            <h3><?= $desc ?></h3>
                            <p>Price : <?= $data[$i]['price'] ?> point</p>
                            <p>
                                <select  name="count" style="width: 40px;">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                </select>
                            </p>
                            <p style="float: left;margin-left: 90px;"><input type="submit" value="Buy Now"></p>
                        </div>
                    </form>
                    <p style="float: right;margin-right: 90px;"><input type="submit" id="shoutbox_submit" onclick="history.back(-1)" value="Cansel" />
                        <?php
                    }
                }
                ?>

            <?php } ?>
    </div>
</div>
