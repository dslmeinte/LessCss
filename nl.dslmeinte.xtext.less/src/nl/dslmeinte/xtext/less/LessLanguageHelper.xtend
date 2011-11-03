package nl.dslmeinte.xtext.less

import com.google.inject.Inject
import java.util.ArrayList
import nl.dslmeinte.xtext.css.css.ClassSelector
import nl.dslmeinte.xtext.css.css.SimpleSelectorSequence
import nl.dslmeinte.xtext.less.less.ExtendedRuleSet
import nl.dslmeinte.xtext.less.less.LessFile
import nl.dslmeinte.xtext.less.less.RuleSetMember
import org.eclipse.xtext.naming.IQualifiedNameConverter

class LessLanguageHelper {

	def mixinCandidates(LessFile lessFile) {
		lessFile.statements.filter(typeof(ExtendedRuleSet)).filter [it.canBeMixin]
	}

	def canBeMixin(ExtendedRuleSet ruleSet) {
		ruleSet.atomicClassName != null
	}

	@Inject
	extension IQualifiedNameConverter qNameConverter

	def qName(ExtendedRuleSet ruleSet) {
		if( ruleSet.atomicClassName == null ) {
			throw new IllegalArgumentException("can only compute q-name for rule set that can act as mixin")
		}
		ruleSet.atomicClassName.toQualifiedName
	}

	def atomicClassName(ExtendedRuleSet ruleSet) {
		if( ruleSet.selectors.size != 1 ) {
			return null
		}
		val firstSelector = ruleSet.selectors.head
		if( !(firstSelector instanceof SimpleSelectorSequence) ) {
			return null
		}
		val firstSelectorSequence = firstSelector as SimpleSelectorSequence
		if( !(firstSelectorSequence.head == null && firstSelectorSequence.simpleSelectors.size == 1) ) {
			return null
		}
		val simpleSelector = firstSelectorSequence.simpleSelectors.head
		if( !(simpleSelector instanceof ClassSelector) ) {
			return null
		}
		(simpleSelector as ClassSelector).name
	}

	/**
	 * Flattens the members of a rule set to a list,
	 * instead of a maximally-unbalanced tree.
	 */
	def Iterable<RuleSetMember> members(ExtendedRuleSet ruleSet) {
		val list = new ArrayList<RuleSetMember>();

		var memberWrapper = ruleSet.firstMemberWrapper
		while( memberWrapper != null ) {
			list.add(memberWrapper.member)
			memberWrapper = memberWrapper.next
		}

		list
	}

}

