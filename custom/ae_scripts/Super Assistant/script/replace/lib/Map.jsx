//;(function(Global) {
var Map = function() {
	this.root = {};
}
Map.prototype.add = function(key, value) {
	this.root[key] = value;
}
Map.prototype.remove = function(key) {
	if(this.root[key]) delete this.root[key];
}
Map.prototype.getValue = function(key) {
	return this.root[key];
}
Map.prototype.setValue = function(key, value) {
	if(this.root[key]) this.root[key] = value;
}
Map.prototype.isValid = function(key) {
	if(this.root[key]) return true;
	else return false;
}
Map.prototype.clear = function() {
	this.root = {};
}
//Global.Map = Map;
//alert(_.dir(Map))
//})(this);
//alert(_.dir(this))