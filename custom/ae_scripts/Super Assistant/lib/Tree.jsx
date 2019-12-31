;(function(Global) {
/***********************************************************************/
function extend(target, source, filter) {//give the source to target
	for(var i in source) {
		if(i != 'children') {
			if(filter && !filter(i, source[i])) continue;
			target[i] = source[i];
		}
	}
	return target;
}
/*************Node**********************************************************/
function Node(type, data) {
	extend(this, {
		type: type,
		parent: null,
		prev: null,
		next: null,
		data: {},
		head: null,//point to the first subnode, subnodes are doubly linked list
		tail: null,
	});
	extend(this.data, data);
}
Node.prototype.add = function(type, data) {
	var parent = this;
	if(data == null) data = {};
	var node = type instanceof Node ? type : new Node(type, data);
	node.parent = parent;

	node.next = null;
	node.prev = parent.tail;
	if(parent.tail == null) {
		parent.head = parent.tail = node;
	}else {
		parent.tail.next = node;
		parent.tail = node;
	}
	return node;
}


Node.prototype.addBehind = function(type, data) {
	var node = type instanceof Node ? type : new Node(type, data);
	node.parent = this.parent;

	var next = this.next;
	this.next = node;
	node.prev = this;
	if(next == null) {
		this.parent.tail = node;
		node.next = null;
	}else {
		next.prev = node;
		node.next = next;
	}
	return node;
}
Node.prototype.addFront = function(type, data) {
	var node = type instanceof Node ? type : new Node(type, data);
	node.parent = this.parent;

	var prev = this.prev;
	this.prev = node;
	node.next = this;
	if(prev == null) {
		this.parent.head = node;
		node.prev = null;
	}else {
		prev.next = node;
		node.prev = prev;
	}
	return node;
}
Node.prototype.moveFront = function(node) {
	this.remove();
	return node.addFront(this);
}
Node.prototype.moveBehind = function(node) {
	this.remove();
	return node.addBehind(this);
}
Node.prototype.moveUp = function() {
	if(this.prev == null) return;
	var prevItem = this.prev;
	this.prev = prevItem.prev;
	if(this.prev == null) this.parent.head = this;
	else prevItem.prev.next = this;
	prevItem.next = this.next;
	if(prevItem.next == null) this.parent.tail = prevItem;
	else this.next.prev = prevItem;
	prevItem.prev = this;
	this.next = prevItem;
}
Node.prototype.moveDown = function() {
	if(this.next == null) return;
	var nextItem = this.next;
	nextItem.prev = this.prev;
	if(nextItem.prev == null) this.parent.head = nextItem;
	else this.prev.next = nextItem;
	this.next = nextItem.next;
	if(this.next == null) this.parent.tail = this;
	else nextItem.next.prev = this;
	nextItem.next = this;
	this.prev = nextItem;
}
Node.prototype.moveTo = function(node) {
	//move this node into other node
	var parent = node;
	while(parent) {
		if(parent == this) return this;
		parent = parent.parent;
	}
	this.remove();
	return node.add(this);
}
Node.prototype.remove = function() {
	var prev = this.prev;
	var next = this.next;
	if(prev == null) {
		this.parent.head = next;
	}else {
		prev.next = next;
	}
	if(next == null) {
		this.parent.tail = prev;
	}else {
		next.prev = prev;
	}
}
Node.prototype.clear = function() {
	//delete all nodes in this node
	this.head = this.tail = null;
}
Node.prototype.children = function() {
	var c = [];
	var next = this.head;
	var tail = this.tail;
	while(next) {
		c.push(next);
		if(next == tail) break;
		next = next.next;
	}
	return c;
}
Node.prototype.find = function(fn) {
	return f(this);
	function f(node) {
		if(fn(node)) return node;
		var next = node.head;
		var tail = node.tail;
		while(next) {
			var newNode = arguments.callee(next);
			if(newNode) return newNode;
			if(next == tail) break;
			next = next.next;
		}
		return null;
	}
}
Node.prototype.getItems = function(fn) {
	var items = [];
	f(this);
	return items;
	function f(node) {
		if(fn(node)) items.push(node);
		var next = node.head;
		var tail = node.tail;
		while(next) {
			arguments.callee(next);
			if(next == tail) break;
			next = next.next;
		}
	}
}
/**************Tree*********************************************************/
Tree = function(json, filter, callback) {
	this.root = new Node('node', {});
	var json = json || {};
	this.readJson(json, filter, callback);
}
Tree.prototype.readJson = function(json, filter, callback) {
	rj(json, this.root, callback);

	function rj(json, node) {
		if(node == null) node = this.root;
		extend(node.data, json, filter);
		if(callback) callback(node);
		if(json.children) {
			var len = json.children.length;
			for(var i = 0; i < len; i++) {
				var type = json.children[i].children? 'node':'item';
				var newNode = node.add(type, {});
				arguments.callee(json.children[i], newNode);
			}
		}
	}
}
Tree.prototype.add = function(type, data) {
	//add node to the root of this
	return this.root.add(type, data);
}
Tree.prototype.children = function() {
	//get children of the root of this
	return this.root.children();
}
Tree.prototype.clear = function() {
	//delete all nodes in root
	this.root.head = this.root.tail = null;
}
Tree.prototype.writeJson = function(filter) {
	return wj(this.root);

	function wj(node) {
		var json = extend({}, node.data, filter);
		if(node.type != 'node') return json;
		//add children
		json.children = [];
		var child = node.head;
		while(child) {
			json.children.push(arguments.callee(child));
			child = child.next;
		}
		return json;
	}
}
Tree.prototype.find = function(fn) {
	return this.root.find(fn);
}
/***********************************************************************/
Global.Tree = Tree;
})(this);