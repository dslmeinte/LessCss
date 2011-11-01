package nl.dslmeinte.xtext.less

import java.util.ArrayList

import com.google.inject.Inject

import org.eclipse.xtext.naming.IQualifiedNameConverter
import org.eclipse.xtext.naming.QualifiedName

import nl.dslmeinte.xtext.css.css.ClassSelector
import nl.dslmeinte.xtext.less.less.LessFile
import nl.dslmeinte.xtext.less.less.RuleSet
import nl.dslmeinte.xtext.less.less.RuleSetMember
import nl.dslmeinte.xtext.less.less.SimpleSelectorIndirection

class LessLanguageHelper {

	def mixinCandidates(LessFile lessFile) {
		lessFile.statements.filter(typeof(RuleSet)).filter([RuleSet rs|rs.canBeMixin])
	}

	def canBeMixin(RuleSet ruleSet) {
		ruleSet.atomicClassName != null
	}

	@Inject
	extension IQualifiedNameConverter qNameConverter

	def qName(RuleSet ruleSet) {
		if( !ruleSet.canBeMixin ) {
			throw new IllegalArgumentException("can only compute q-name for rule set that can act as mixin")
		}
		ruleSet.atomicClassName.toQualifiedName
	}

	def atomicClassName(RuleSet ruleSet) {
		if( ruleSet.selectors.size != 1 ) {
			return null
		}
		val atomicSelector = ruleSet.selectors.head
		if( !(atomicSelector instanceof SimpleSelectorIndirection) ) {
			return null
		}
		val indirection = (atomicSelector as SimpleSelectorIndirection).selector
		if( !(indirection instanceof ClassSelector) ) {
			return null
		}
		(indirection as ClassSelector).name
	}

	/**
	 * Flattens the members of a rule set to a list,
	 * instead of a maximally-unbalanced tree.
	 */
	def Iterable<RuleSetMember> members(RuleSet ruleSet) {
		val list = new ArrayList<RuleSetMember>();

		var memberWrapper = ruleSet.firstMemberWrapper
		while( memberWrapper != null ) {
			list.add(memberWrapper.member)
			memberWrapper = memberWrapper.next
		}

		list
	}

}

