package nl.dslmeinte.xtext.less.scoping

import nl.dslmeinte.xtext.less.less.LessFile
import nl.dslmeinte.xtext.less.less.RuleSet

import org.eclipse.emf.ecore.EReference
import org.eclipse.xtext.scoping.IScope
import org.eclipse.xtext.scoping.impl.AbstractDeclarativeScopeProvider
import org.eclipse.xtext.scoping.Scopes
import nl.dslmeinte.xtext.less.less.ClassSelector
import org.eclipse.xtext.naming.QualifiedName
import com.google.inject.Inject
import nl.dslmeinte.xtext.less.LessLanguageHelper

class LessScopeProviderImpl extends AbstractDeclarativeScopeProvider {

	@Inject
	extension LessLanguageHelper lessLanguageHelper

	// TODO  use my AbstractDeclarateAnnotationBasedScopeProvider here
	def IScope scope_MixinCall_ruleSet(LessFile lessFile, EReference ref) {
		Scopes::scopeFor(lessFile.mixinCandidates, [ it | it.qName ], IScope::NULLSCOPE)
	}

}
