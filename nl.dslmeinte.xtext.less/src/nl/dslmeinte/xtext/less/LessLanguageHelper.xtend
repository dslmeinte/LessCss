package nl.dslmeinte.xtext.less

import com.google.inject.Inject
import nl.dslmeinte.xtext.css.css.ClassSelector
import nl.dslmeinte.xtext.css.css.IDSelector
import nl.dslmeinte.xtext.less.less.ExtendedRuleSet
import nl.dslmeinte.xtext.less.less.LessFile
import nl.dslmeinte.xtext.less.less.SimpleSelectorSequence
import org.eclipse.emf.ecore.EObject
import org.eclipse.xtext.naming.IQualifiedNameConverter

class LessLanguageHelper {

	def mixinCandidates(LessFile it) {
		ruleSets.filter[it.canBeMixin]
	}

	def private canBeMixin(ExtendedRuleSet it) {
		atomicClassName != null
	}

	def namespaceCandidates(LessFile it) {
		ruleSets.filter[it.canBeNamespace]
	}

	def private canBeNamespace(ExtendedRuleSet it) {
		atomicID != null
	}

	def private ruleSets(LessFile it) {
		statements.filter(typeof(ExtendedRuleSet))
	}

	@Inject
	extension IQualifiedNameConverter qNameConverter

	def qNameMixin(ExtendedRuleSet it) {
		if( atomicClassName == null ) {
			throw new IllegalArgumentException("can only compute q-name for rule set that can act as mixin")
		}
		atomicClassName.toQualifiedName
	}

	def qNameNamespace(ExtendedRuleSet it) {
		if( atomicID == null ) {
			throw new IllegalArgumentException("can only compute q-name for rule set that can act as namespace")
		}
		atomicID.toQualifiedName
	}

	def private atomicClassName(ExtendedRuleSet it) {
		atomicSelector(typeof(ClassSelector))
	}

	def private atomicID(ExtendedRuleSet it) {
		atomicSelector(typeof(IDSelector))
	}

	/**
	 * @returns The name of the atomic selector of the given class
	 * 			or {@code null} if the selector doesn't conform to that pattern.
	 */
	def private atomicSelector(ExtendedRuleSet it, Class<? extends EObject> clazz) {
		if( selectors.size != 1 ) {
			return null
		}
		val firstSelector = selectors.head
		if( !(firstSelector instanceof SimpleSelectorSequence) ) {
			return null
		}
		val firstSelectorSequence = firstSelector as SimpleSelectorSequence
		if( !(firstSelectorSequence.head == null && firstSelectorSequence.simpleSelectors.size == 1) ) {
			return null
		}
		val simpleSelector = firstSelectorSequence.simpleSelectors.head
		if( !clazz.isAssignableFrom(simpleSelector.^class) ) {
			return null
		}
		// rely on EMF to get 'name' feature:
		simpleSelector.eGet(simpleSelector.eClass.getEStructuralFeature("name")) as String
	}

	/**
	 * Computes a nesting of variables which are in scope.
	 */
	def variablesInNestedScope(EObject context) {
		// ascend to level of ExtendedRuleSet or LessFile:
		/*
		 * Possible (inverse) containment trees:
		 * VariableDeclaration
		 * 		-> VariableDefinition.name -> ...
		 */
	}

}

