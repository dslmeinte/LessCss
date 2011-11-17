package nl.dslmeinte.xtext.css.test

import java.io.File
import nl.dslmeinte.xtext.css.CSSStandaloneSetup
import nl.dslmeinte.xtext.test.util.XtextTestsSupport
import org.junit.Assert

/**
 * Parses all CSS test files in the cloudhead/less.js repository,
 * located in /test/css. Note that this directory must be symlinked
 * as 'lessjs-test-css' in this project's root.
 */
class AllLessJsCssTests extends XtextTestsSupport {

	override protected setUp() {
		super.setUp()
		with(typeof(CSSStandaloneSetup))
	}

	def void test_all_LessJs_css_tests() {
		val dir = new File("lessjs-test-css")
		var success = true
		for( file : dir.listFiles
						.filter[it.name.endsWith(".css")]
						.sortBy[it | { val name = it.name; name.substring(0, name.lastIndexOf(".css")) } ]
		) {
			println("parsing " + file.name + ":")
			val result = test(file)
			if( file.name != 'colors.css' ) {
				success = success && result
			}
			println("")
			println("")
		}
		if( !success ) {
			Assert::fail("there were syntactic/semantic errors")
		}
	}

}
