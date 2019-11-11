package peg.generator;

import peg.php.PNamespace;
import peg.generator.ModuleWriter.TypeKind;
import peg.php.PClass;
import peg.generator.NamespaceTree.Node;

class NamespaceGenerator {
	final node:Node;
	final gen:Generator;
	final phpNamespace:Array<String>;
	final phpNamespaceStr:String;
	final haxePackage:Array<String>;
	final haxePackageStr:String;

	public function new(node:Node, gen:Generator) {
		this.node = node;
		this.gen = gen;
		phpNamespace = node.getNamespace();
		phpNamespaceStr = phpNamespace.join('\\');
		haxePackage = phpNamespace.map(s -> s.toLowerCase());
		haxePackageStr = haxePackage.join('.');
	}

	public function run() {
		for(data in node.parsedData) {
			for (cls in data.classes) {
				generateClass(cls, data);
			}
		}

	}

	function generateClass(cls:PClass, ns:PNamespace) {
		var hxName = cls.name.charAt(0).toUpperCase() + cls.name.substr(1);
		var hx = new ModuleWriter(haxePackageStr, hxName);
		hx.isAbstract = cls.isAbstract;
		hx.isFinal = cls.isFinal;
		hx.isTrait = cls.isTrait;
		hx.isInterface = cls.isInterface;

		hx.native = '$phpNamespaceStr\\${cls.name}';

		for (u in ns.uses) {
			switch u {
				case UClass(type, alias): hx.addImport(type, alias);
				case UTrait(traitsPaths, aliases):
				case UFunction(functionPath, alias):
				case UConst(constPath):
			}
		}

		switch cls.parent {
			case null:
			case parent: hx.addExtends(parent);
		}

		for (i in cls.interfaces) {
			if(cls.isInterface) {
				hx.addExtends(i);
			} else {
				hx.addImplements(i);
			}
		}

		gen.writeModule(haxePackage, hxName,  hx.toString());
	}
}