package nl.dslmeinte.xtext.test.util

import java.io.File
import java.io.FileInputStream
import org.eclipse.emf.ecore.resource.Resource$Diagnostic
import org.eclipse.emf.ecore.util.Diagnostician
import org.eclipse.xtext.junit.AbstractXtextTests
import org.eclipse.xtext.EcoreUtil2

/**
 * Support class (which ought to be abstract) to help with unit testing files,
 * without using the classes from org.eclipse.xtext.junit4.parameterized
 * (which are either limited or which I don't understand).
 */
class XtextTestsSupport extends AbstractXtextTests {

	protected Diagnostician diagnostician

	override protected setUp() {
		super.setUp()
		diagnostician = new Diagnostician()
	}

	def test(File file) {
		val input = new FileInputStream(file)
		val eObject = getModelAndExpect(input, AbstractXtextTests::UNKNOWN_EXPECTATION)
		val resource = eObject.eResource
		EcoreUtil2::resolveAll(resource)

		for( e : resource.errors ) {
			e.print("error")
		}

		for( w : resource.warnings ) {
			w.print("warning")
		}

		val issues = diagnostician.validate(eObject).children
		for( i : issues ) {
			i.print
		}
		return issues.size == 0 && resource.errors.size == 0
	}

	def private print(Diagnostic it, String type) {
		println( '''LÇlineÈÇsafeColumnÈ		ÇtypeÈ		ÇmessageÈ'''.toString )
	}

	def private print(org.eclipse.emf.common.util.Diagnostic it) {
		println( '''ÇseverityÈ	ÇmessageÈ'''.toString )		// TODO  map severity int -> String
	}

	def private safeColumn(Diagnostic it) {
		try {
			"@" + column
		} catch( UnsupportedOperationException e ) {
			""
		}
	}

	def fileInCurrentJavaPackage(String fileName) {
		new File("src/" + ^class.^package.name.replace('.', '/') + "/" + fileName)
	}

	def file(String fileName) {
		new File(fileName)
	}

}
