pragma solidity ^0.8.17;

import './Owner.sol';
contract TestContract is Owner {

enum typeBien {terrain,appartement,maison}

struct bien {  // apparteement bien ou maison ou terrain
    uint id; // id du bien
    string name; //nom du bien
    uint price;// prix
    typeBien _typeBien; // définit le tyoe de bien(terrain,appartemeent,maison)
}

uint compteur;

mapping(address => bien[]) Possessions; // un proprietaire est representé par une adresse d'un compte eth peut osseder 0 ou plusieurs bien


// fonctionnalité pour ajouter un bien ,on aura besoin de l'adresse du proprietaire,nom,prix,et le type
// uniquement le proprietaire du contrat peut ajouter un bien dans le contrat intelligent en le reliant à un certains proprietaire
// en indiquant le nom,prix,type de bien
function addBien(address _proprietaire,string memory _name, uint _price, typeBien _typeBien) public isOwner { 
    
    require(_price > 1000,"le bien doit couter plus de 1000 wei");
    require(uint(_typeBien) >= 0, "le type de bien doit etre compris entre 0 et 2");
    require(uint(_typeBien) <=2, "le type de bien doit etre compris entre 0 et 2");
    Possessions[_proprietaire].push(bien(compteur,_name,_price,_typeBien)); // ajouter la structure bien 
    // compteur permet de gerer les id du bien,
    compteur++;

}
// permet de recuperer tous les bien d'un certains proprietaire du contrat intelligent,
function getBiens(address _proprietaire) public view isOwner returns(bien[] memory) {
    return Possessions[_proprietaire];
}
// recuperer le nombre de bien d'un proprietaire
function getNombreBiens(address _proprietaire) public view isOwner returns(uint) {
    return Possessions[_proprietaire].length;
}

//recuprer les bien de la personne qui appelle la fonction
function getMesBiens() public view returns(bien[] memory ){
    return Possessions[msg.sender];
}
}