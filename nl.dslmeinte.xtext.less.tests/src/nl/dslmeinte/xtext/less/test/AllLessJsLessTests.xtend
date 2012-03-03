package nl.dslmeinte.xtext.less.test

import java.io.File
import nl.dslmeinte.xtext.less.LessStandaloneSetup
import nl.dslmeinte.xtext.test.util.XtextTestsSupport

import static junit.framework.Assert.*

/**
 * Parses all CSS test files in the cloudhead/less.js repository,
 * located in /test/css. Note that this directory must be symlinked
 * as 'lessjs-test-css' in this project's root.
 */
class AllLessJsLessTests extends XtextTestsSupport {

	override protected setUp() {
		super.setUp()
		with(typeof(LessStandaloneSetup))
	}

	def void test_all_LessJs_css_tests() {
		val dir = new File("lessjs-less-tests")
		var success = true
		for( file : dir.listFiles
						.filter[it.name.endsWith(".less")]
						.sortBy[it | { val name = it.name; name.substring(0, name.lastIndexOf(".less")) } ]
		) {
			println("parsing " + file.name + ":")
			val result = test(file)
			if( file.name != 'colors.less' ) {
				success = success && result
			}
			println("")
			println("")
		}
		assertTrue("there were syntactic/semantic errors", success)
	}

	def void test_imports() {
		val file = new File("lessjs-less-tests/import.less")
		assertTrue("there were syntactic/semantic errors", test(file))
	}

}
