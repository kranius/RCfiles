select * from dst_batch b
inner join dst_sync_instruction si on si.batch_id = b.id
inner join dst_partner_order po on po.id = si.partner_order_id;


select distinct key_name, md.field_name, md.field_level, mp.p#
from amn_metadata_dictionary md
inner join amn_metadata_partition mp on mp.name = md.field_name
where 1=1 
and key_name like 'LOCAL_ASSET_DIGITAL_TITLE'
and entity =
 --'LOCAL_PRODUCT'
--'PRODUCT'
'LOCAL_ASSET'
--'ASSET'
order by field_name;



SELECT p.upc REF, a.isrc, a.asset_type, a.id, la.country, m.value, p.owning_country
FROM amn_product p
INNER JOIN amn_component c ON c.product_id = p.id
INNER JOIN amn_resource r ON r.component_id = c.id
INNER JOIN amn_asset a ON a.id = r.asset_id
INNER JOIN amn_local_asset la ON la.asset_id = a.id
INNER JOIN amn_metadata m ON m.metadata_group_id = la.metadata_group_id
INNER JOIN amn_metadata_partition mp ON m.p# = mp.p# AND mp.name = m.name
AND object_type ='LOCAL_ASSET'
WHERE m.name = 'asset_digital_title'
AND p.upc = '00602517164871';

update amn_product set owning_country='US' where upc='00050087142759';

 insert into idt_user_authority (user_id, authority_id)
select us.id user_id, au.id authority_id from idt_authority au, idt_user us
where au.name like '%ACCESS_OPS_%'
and us.name like 'ops_superuser';


select p.upc, p.version_id
from amn_product p 
where p.upc='00050087142759';
