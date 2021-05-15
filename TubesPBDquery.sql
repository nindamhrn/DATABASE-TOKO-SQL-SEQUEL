select mb.nama_member, byr.tanggal_membayar, sum(byr.total_bayar) as total
from barang b, membeli m, member mb, membayar byr, detil_membayar dm
where b.KODE_BARANG = m.KODE_BARANG
and m.ID_MEMBELI = byr.ID_MEMBELI
and m.ID_MEMBER = mb.ID_MEMBER
order by sum(byr.total_bayar)
group by mb.nama_member, byr.tanggal_membayar;

select * from 
(select round(sum(mm.total_bayar)) "Total Bayar", mb.id_member "ID Member", m.nama_member
from membayar mm, membeli mb, member m
where mm.id_membeli = mb.id_membeli
and m.ID_MEMBER = mb.ID_MEMBER
group by mb.id_member, m.nama_member
order by sum(mm.total_bayar) desc
)
where rownum = 1;

select mb.nama_member, sum(byr.total_bayar) as jumlah
from member mb, membayar m, membeli mbl
where mb.ID_MEMBER = mbl.ID_MEMBER
and mbl.id_membeli = m.id_membeli
having sum(byr.total_bayar) = (select max(jumlah) as maxs 
from (sum(byr.total_bayar) as jumlah
from membeli group by total_bayar))
group by mb.nama_member;