package nl.dslmeinte.xtext.less

import nl.dslmeinte.xtext.less.less.*
import org.eclipse.xtext.naming.QualifiedName

class LessLanguageHelper {

	def topLevelClassRuleSets(LessFile lessFile) {
		lessFile.statements.filter(typeof(RuleSet)).filter([rs|rs.isClass])
	}

	def isClass(RuleSet ruleSet) {
		ruleSet.selector instanceof ClassSelector
	}

	def qName(RuleSet ruleSet) {
		if( !ruleSet.isClass ) {
			throw new IllegalArgumentException("can only compute q-name for class rule set")
		}
		QualifiedName::create( (ruleSet.selector as ClassSelector).name )
	}

}

