select immunityidType
from Type
left join Type_Immune_To
on idType=Type_Immune_To.targetidType
left join Type_Resistant_To
on idType=Type_Resistant_To.targetidType
left join Type_Weak_To
on idType=Type_Weak_To.targetidType
where idType=? and immunityidType is not null
