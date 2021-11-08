-- Afficher les 10 premiers éléments de la table Produit triés par leur prix unitaire 

SELECT * 
FROM produit 
ORDER BY PrixUnit 
LIMIT 10;

-- Afficher les trois produits les plus chers

SELECT * 
FROM produit 
ORDER BY PrixUnit 
DESC 
LIMIT 3;

-- Lister les clients français installés à Paris dont le numéro de fax n'est pas renseigné

SELECT * 
FROM client 
WHERE Ville = 'Paris' AND Fax IS NULL;

-- Lister les clients français, allemands et canadiens

SELECT * 
FROM client 
WHERE Pays IN ('France','Canada', 'Germany');

-- Lister les clients dont le nom de société contient "restaurant" 

SELECT * 
FROM client 
WHERE Societe LIKE '%restaurant%';

-- Lister les descriptions des catégories de produits (table Categorie)

SELECT DISTINCT Description 
FROM categorie;

-- Lister les différents pays et villes des clients, le tout trié par ordre alphabétique croissant du pays et décroissant de la ville

SELECT DISTINCT Pays, Ville 
FROM client 
ORDER BY pays, Ville 
DESC;

-- Lister les fournisseurs français, en affichant uniquement le nom, le contact et la ville, triés par ville

SELECT DISTINCT Societe, Contact, Ville 
FROM fournisseur 
WHERE Pays = 'France' 
ORDER BY Ville;

-- Lister les produits (nom en majuscule et référence) du fournisseur n° 8 dont le prix unitaire est entre 10 et 100 euros, en renommant les attributs pour que ça soit explicite

SELECT UCASE(NomProd) AS NOM, RefProd AS reference 
FROM produit 
WHERE NoFour = 8 AND PrixUnit BETWEEN 10 AND 100;
        --------------------------------------------
SELECT UCASE(NomProd) AS NOM, RefProd AS reference 
FROM produit 
WHERE NoFour = 8 AND PrixUnit > 10 AND PrixUnit < 100;

/*
-- La table DetailsCommande contient l'ensemble des lignes d'achat de chaque commande. Calculer, pour la commande numéro 10251, pour chaque produit acheté dans celle-ci, le montant de la ligne d'achat en incluant la remise (stockée en proportion dans la table). Afficher donc (dans une même requête) :

- le prix unitaire, 
- la remise, 
- la quantité, 
- le montant de la remise, 
le montant à payer pour ce produit
 */

SELECT PrixUnit, Remise, Qte, (PrixUnit*Remise) AS MontantRemise,(PrixUnit-PrixUnit*Remise)*Qte AS MontantTotal 
FROM detailsCommande 
WHERE NoCom = 10251;

-- A partir de la table Produit, afficher "Produit non disponible" lorsque l'attribut Indisponible vaut 1, et "Produit disponible" sinon.

SELECT NomProd, IF(Indisponible = 0, 'Produit disponible', 'Produit non disponible') AS disponibilite
FROM produit;
        ---------------------------------------------------------
SELECT Indisponible,
    CASE 
        WHEN Indisponible = 1 THEN "Produit non disponible"
        ELSE "Produit disponible"
    END AS Disponibilite
FROM produit

/*
-- Dans une même requête, sur la table Client :
* Concaténer les champs Adresse, Ville, CodePostal et Pays dans un nouveau champ nommé Adresse_complète, pour avoir : Adresse, CodePostal, Ville, Pays
* Extraire les deux derniers caractères des codes clients
* Mettre en minuscule le nom des sociétés
* Remplacer le terme "Owner" par "Freelance" dans Fonction
Indiquer la présence du terme "Manager" dans Fonction
*/

SELECT CONCAT(Adresse, ', ', Codepostal, ', ', Ville, ', ', Pays) AS Adresse_complete,  
RIGHT(CodeCli, 2) AS CodeCli, 
-- ou SUBSTR(CodeCli, -2) --
LCASE(Societe) AS Societe, REPLACE(Fonction, 'Owner', 'Freelance') 
FROM client 
WHERE Fonction LIKE '%Manager%';

-- Afficher le jour de la semaine en lettre pour toutes les dates de commande, afficher "week-end" pour les samedi et dimanche, 

SELECT NoCom, DateCom,
    CASE
        WHEN DATE_FORMAT(DateCom, "%W") IN ('Saturday', 'Sunday') THEN 'week-end'
        ELSE DATE_FORMAT(DateCom, "%W")
    END AS Date
        ---------------------------------------------------------
SELECT *, 
IF(WEEKDAY(DateCom) < 5, DATE_FORMAT(DateCom, "%W"), 'weekend') DateCom
FROM commande

-- Calculer le nombre de jours entre la date de la commande (DateCom) et la date butoir de livraison (ALivAvant), pour chaque commande, On souhaite aussi contacter les clients 1 mois après leur commande. ajouter la date correspondante pour chaque commande

SELECT DATEDIFF(ALivAvant, DateCom) AS nbr_jours, DATE_ADD(DateCom, INTERVAL 1 MONTH ) AS Date_contacter_client 
FROM commande;

-- Calculer le nombre d'employés qui sont "Sales Manager » 

SELECT COUNT(*) as Nbr_Sales_Manager 
FROM employe 
WHERE Fonction = 'Sales Manager';

-- Calculer le nombre de produits de catégorie 1, des fournisseurs 1 et 18

SELECT NoFour, COUNT(CodeCateg) AS Nbr_Produit 
FROM produit 
WHERE NoFour IN(1, 18) AND CodeCateg = 1 
GROUP BY NoFour;

-- Calculer le nombre de pays différents de livraison

SELECT COUNT(DISTINCT PaysLiv) AS Nbr_pays 
FROM commande;

-- Calculer le nombre de commandes réalisées le en Aout 2006.

SELECT COUNT(*) AS Nbr_commande 
FROM commande 
WHERE DateCom LIKE '2006-08%';

-- Calculer le coût du port minimum et maximum des commandes , ainsi que le coût moyen du port pour les commandes du client dont le code est "QUICK" (attribut CodeCli)

SELECT MIN(Port) AS Port_min, MAX(Port) AS Port_Max, AVG(Port) AS Port_Moyen 
FROM commande 
WHERE CodeCli = 'QUICK';

-- Pour chaque messager (par leur numéro : 1, 2 et 3), donner le montant total des frais de port leur correspondant

SELECT NoMess, SUM(Port) 
FROM commande 
GROUP BY NoMess;

-- Donner le nombre d'employés par fonction

SELECT Fonction, COUNT(NoEmp) AS Nbr_Employe 
FROM employe 
GROUP BY Fonction;

-- Donner le nombre de catégories de produits fournis par chaque fournisseur

SELECT NoFour, COUNT(DISTINCT CodeCateg) 
FROM produit 
GROUP BY NoFour;

-- Donner le prix moyen des produits pour chaque fournisseur et chaque catégorie de produits fournis par celui-ci

SELECT NoFour, CodeCateg, AVG(PrixUnit) AS Prix_moyen 
FROM produit 
GROUP BY NoFour, CodeCateg;

-- Lister les fournisseurs ne fournissant qu'un seul produit

SELECT NoFour, COUNT(RefProd) Nbr_Produit 
FROM produit 
GROUP BY NoFour 
HAVING Nbr_Produit=1;

-- Lister les fournisseurs ne fournissant qu'une seule catégorie de produits

SELECT NoFour
FROM produit 
GROUP BY NoFour 
HAVING COUNT(DISTINCT CodeCateg)=1;

-- Lister le Products le plus cher pour chaque fournisseur, pour les Products de plus de 50 euro

SELECT NoFour, PrixUnit, MAX(prixUnit)
FROM produit 
GROUP BY NoFour, PrixUnit
HAVING MAX(PrixUnit)>50;

-- Récupérer les informations des fournisseurs pour chaque produit

SELECT * 
FROM fournisseur 
NATURAL JOIN produit;

-- Afficher les informations des commandes du client "Lazy K Kountry Store »

SELECT * 
FROM client 
NATURAL JOIN commande 
WHERE Societe = "Lazy K Kountry Store";

-- Afficher le nombre de commande pour chaque messager (en indiquant son nom)

SELECT NomMess, COUNT(NoCom) AS Nbr_commande 
FROM messager 
NATURAL JOIN commande 
GROUP BY NomMess;

-- Récupérer les informations des fournisseurs pour chaque produit, avec une jointure interne

SELECT * 
FROM fournisseur F 
INNER JOIN produit P ON F.NoFour = P.NoFour;

-- Afficher les informations des commandes du client "Lazy K Kountry Store", avec une jointure interne

SELECT * 
FROM client C 
INNER JOIN commande Co ON C.Codecli = Co.CodeCli 
WHERE Societe = "Lazy K Kountry Store";

-- Afficher le nombre de commande pour chaque messager (en indiquant son nom), avec une jointure interne

SELECT NomMess, COUNT(NoCom) AS Nbr_commande 
FROM messager M 
INNER JOIN commande C ON M.NoMess = C.NoMess 
GROUP BY NomMess;

-- Compter pour chaque produit, le nombre de commandes où il apparaît, même pour ceux dans aucune commande

SELECT P.RefProd, COUNT(NoCom) AS Nbr_Commande_Per_Product 
FROM produit P 
LEFT JOIN detailsCommande Dc 
ON P.RefProd = Dc.RefProd 
GROUP BY RefProd;

-- Lister les produits n'apparaissant dans aucune commande

SELECT P.RefProd
FROM produit P 
LEFT JOIN detailsCommande Dc 
ON P.RefProd = Dc.RefProd 
WHERE Dc.NoCom is NULL;

-- Existe-t'il un employé n'ayant enregistré aucune commande ?

SELECT E.Nom
FROM employe E 
LEFT OUTER JOIN commande C 
ON E.NoEmp = C.NoEmp
WHERE C.NoCom is NULL;

-- Récupérer les informations des fournisseurs pour chaque produit, avec jointure à la main

SELECT *
FROM produit P, fournisseur F 
WHERE P.NoFour = F.NoFour;

-- Afficher les informations des commandes du client "Lazy K Kountry Store", avec jointure à la main

SELECT * 
FROM client C, commande Co 
WHERE C.Codecli = Co.CodeCli AND Societe = "Lazy K Kountry Store";

-- Afficher le nombre de commande pour chaque messager (en indiquant son nom), avec jointure à la main

SELECT NomMess, COUNT(NoCom) AS Nbr_commande 
FROM messager M,  commande C 
WHERE M.NoMess = C.NoMess 
GROUP BY NomMess;

-- Lister les employés n'ayant jamais effectué une commande, via une sous-requête

SELECT NoEmp, Nom
FROM employe
WHERE NoEmp NOT IN (SELECT NoEmp FROM commande);

-- Nombre de produits proposés par la société fournisseur "Ma Maison", via une sous-requête

SELECT COUNT(RefProd)
FROM produit
WHERE NoFour = (SELECT NoFour FROM fournisseur WHERE Societe = "Ma Maison");

-- Nombre de commandes passées par des employés sous la responsabilité de "Buchanan Steven"

SELECT COUNT(NoEmp) AS Nbr_Compte FROM Commande WHERE NoEmp IN (
	SELECT NoEmp FROM employe WHERE RendCompteA = (
		SELECT NoEmp FROM employe WHERE Nom = "Buchanan"));

-- Lister les produits n'ayant jamais été commandés, à l'aide de l'opérateur EXISTS

SELECT RefProd
FROM produit P
WHERE NOT EXISTS (
	SELECT RefProd FROM detailsCommande Dc WHERE P.RefProd = Dc.RefProd);

-- Lister les fournisseurs dont au moins un produit a été livré en France

SELECT Societe
        FROM fournisseur
        WHERE EXISTS (SELECT * 
                    FROM produit P, detailsCommande Dc, commande C
                    WHERE P.RefProd = Dc.RefProd
                    AND Dc.NoCom = C.NoCom
                    AND PaysLiv = "France"
                    AND NoFour = F.NoFour)
-- Liste des fournisseurs qui ne proposent que des boissons (drinks)

SELECT F.Societe
    FROM fournisseur F
    WHERE EXISTS 
        (SELECT * FROM produit P, categorie C WHERE P.NoFour = F.NoFour AND P.CodeCateg = C.CodeCateg AND C.NomCateg = "drinks")
    AND NOT EXISTS 
        (SELECT * FROM produit, categorie WHERE P.NoFour = F.NoFour AND P.CodeCateg = C.CodeCateg AND C.NomCateg <> "drinks")

-- Lister les employés (nom et prénom) étant "Representative" ou étant basé au Royaume-Uni (UK)

SELECT Nom, Prenom
    FROM employe
    WHERE Fonction LIKE "%Representative"
UNION  
SELECT Nom, Prenom
    FROM employe
    WHERE Pays = "UK";

-- Lister les clients (société et pays) ayant commandés via un employé situé à Londres ("London" pour rappel) ou ayant été livré par "Speedy Express"

SELECT Societe, Cl.Pays
    FROM client Cl, commande Co, employe E
    WHERE Cl.CodeCli = Co.CodeCli
    AND Co.NoEmp = E.NoEmp
    AND E.Ville = "London"
UNION
SELECT Societe, Cl.Pays
    FROM client Cl, commande Co, messager M
    WHERE Cl.CodeCli = Co.CodeCli
    AND Co.NoMess = M.NoMess
    AND NomMess = "Speedy Express";

-- Lister les employés (nom et prénom) étant "Representative" et étant basé au Royaume-Uni (UK)

SELECT Nom, Prenom
    FROM employe
    WHERE Fonction LIKE "%Representative"
INTERSECT
SELECT Nom, Prenom
    FROM employe
    WHERE Pays = "UK"; 
    ------------ Impossible à tester avec MySQL ------------

-- Lister les clients (société et pays) ayant commandés via un employé basé à "Seattle" et ayant commandé des "Desserts"

SELECT Societe, Cl.Pays
    FROM client Cl, commande Co, employe E
    WHERE Cl.CodeCli = Co.CodeCli
    AND Co.NoEmp = E.NoEmp
    AND E.Ville = "Seattle"
INTERSECT
SELECT Societe, Cl.Pays
    FROM client Cl, commande Co, detailsCommande Dc,
         Produit P, Categorie Ca
    WHERE Cl.CodeCli = Co.CodeCli
    AND Co.NoCom = Dc.NoCom
    AND Dc.RefProd = P.RefProd
    AND P.CodeCateg = Ca.CodeCateg
    AND NomCateg = "Desserts";
    ------------ Impossible à tester avec MySQL ------------

-- Lister les employés (nom et prénom) étant "Representative" mais n'étant pas basé au Royaume-Uni (UK)

SELECT Nom, Prenom
    FROM employe
    WHERE Fonction LIKE "%Representative"
EXCEPT
SELECT Nom, Prenom
    FROM employe
    WHERE Pays = "UK";
    ------------ Impossible à tester avec MySQL ------------

-- Lister les clients (société et pays) ayant commandés via un employé situé à Londres ("London" pour rappel) et n'ayant jamais été livré par "United Package"

SELECT Societe, Cl.Pays
    FROM client Cl, commande Co, employe E
    WHERE Cl.CodeCli = Co.CodeCli
    AND Co.NoEmp = E.NoEmp
    AND E.Ville = "London"
EXCEPT
SELECT Societe, Cl.Pays
    FROM client Cl, commande Co, messager M
    WHERE Cl.CodeCli = Co.CodeCli
    AND Co.NoMess = M.NoMess
    AND NomMess = "United Package";
    ------------ Impossible à tester avec MySQL ------------
