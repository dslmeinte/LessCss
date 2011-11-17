package nl.dslmeinte.xtext.less.test

import nl.dslmeinte.xtext.less.LessStandaloneSetup
import nl.dslmeinte.xtext.test.util.XtextTestsSupport
import org.junit.Assert

class ExamplesTest extends XtextTestsSupport {

	override protected setUp() {
		super.setUp()
		with(typeof(LessStandaloneSetup));
	}

	def void test_all_examples_at_once() {
		Assert::assertTrue("there are syntactical/semantic errors", test("examples.less".fileInCurrentJavaPackage))
	}

}
