package test;

class TestAll {
	static public function main() {

		for (file in new peg.SourcesIterator('vendor/symfony')) {
			Sys.println('Parsing ${file.path}');

			for (namespace in file.parse()) {
				// Sys.println('namespace: ${namespace.name}');

				// for (u in namespace.uses) {
				// 	Sys.println('  use ${u.toString()}');
				// }

				// for (cls in namespace.classes) {
				// 	var kwd = cls.isInterface ? 'interface' : 'class';
				// 	Sys.println('  $kwd ${cls.name} extends ${cls.parent} implements ${cls.interfaces.join(', ')}');
				// 	for (c in cls.constants) {
				// 		Sys.println('    const ${c.name}');
				// 	}
				// 	for (v in cls.vars) {
				// 		Sys.println('    var ${v.name}');
				// 	}
				// 	for (fn in cls.functions) {
				// 		Sys.println('    function ${fn.name}');
				// 	}
				// }
			}
		}
	}
}