

-- FROM (table)

/* 
Quando si usa una TABELLA DINAMICA nella clausula FROM
questa viene trattata come una tabella originale e la
query esterna pu� selezionare una o pi� colonne della
tabella dinamica.
*/

select e.*
from (select FirstName, LastName from Employees) e;






